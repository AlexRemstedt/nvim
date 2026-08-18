-- lua/util/dap_config.lua
-- Scaffolds a project-local DAP config (`.dap/launch.json`) that the
-- `project-launch` provider in `lua/plugins/dap.lua` reads. The FastAPI
-- template sources its port from a `.env` file when present, otherwise it
-- prompts for the missing parameters.
local M = {}

local uv = vim.uv or vim.loop

local DAP_DIR = ".dap"
local LAUNCH_FILE = DAP_DIR .. "/launch.json"

-- Base FastAPI launch configuration. `%s` placeholders are, in order, the
-- app import string and the port.
local TEMPLATE = [[{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "FastAPI",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": ["%s", "--host", "127.0.0.1", "--port", "%s", "--reload"],
      "jinja": true,
      "justMyCode": false
    }
  ]
}
]]

-- Read `key` from the `.env` file in `dir`, returning nil when the file or
-- the key is absent (or the value is empty).
local function read_env(dir, key)
  local f = io.open(dir .. "/.env", "r")
  if not f then
    return nil
  end

  local value
  for line in f:lines() do
    local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
    if k == key then
      -- Strip a single layer of surrounding quotes.
      value = v:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
      break
    end
  end
  f:close()

  return (value and value ~= "") and value or nil
end

local function write_config(dir, app, port)
  vim.fn.mkdir(dir .. "/" .. DAP_DIR, "p")
  local path = dir .. "/" .. LAUNCH_FILE

  local f, err = io.open(path, "w")
  if not f then
    vim.notify("Failed to write " .. path .. ": " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  f:write(string.format(TEMPLATE, app, port))
  f:close()

  vim.notify(("Created %s (FastAPI on port %s)"):format(LAUNCH_FILE, port), vim.log.levels.INFO)
end

-- Resolve a value from `.env`, falling back to a prompt with `default`.
-- Calls `cb(value)` once resolved, or does nothing when the prompt is
-- cancelled.
local function resolve(dir, env_key, prompt, default, cb)
  local value = read_env(dir, env_key)
  if value then
    return cb(value)
  end

  vim.ui.input({ prompt = prompt, default = default }, function(input)
    if input == nil or input == "" then
      return
    end
    cb(input)
  end)
end

-- Create a FastAPI `.dap/launch.json` in the current working directory,
-- prompting for any parameters not provided via `.env`.
function M.create_fastapi()
  local dir = vim.fn.getcwd()

  local function proceed()
    resolve(dir, "APP_MODULE", "App import string: ", "app.main:app", function(app)
      resolve(dir, "PORT", "Port: ", "8000", function(port)
        write_config(dir, app, port)
      end)
    end)
  end

  -- Confirm before clobbering an existing config.
  if uv.fs_stat(dir .. "/" .. LAUNCH_FILE) then
    vim.ui.select({ "No", "Yes" }, { prompt = LAUNCH_FILE .. " already exists. Overwrite?" }, function(choice)
      if choice == "Yes" then
        proceed()
      end
    end)
  else
    proceed()
  end
end

return M
