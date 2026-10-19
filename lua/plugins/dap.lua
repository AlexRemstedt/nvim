-- lua/plugins/dap.lua
-- Standalone DAP (Debug Adapter Protocol) setup. This file replaces the
-- LazyVim extra `lazyvim.plugins.extras.dap.core`. It defines the same
-- keymaps, signs, and launch.json support. It also adds the project-local
-- `.dap/launch.json` provider and the FastAPI scaffolder.

---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

-- Read `.dap/launch.json` from the current working directory. Return the
-- configurations it holds, or an empty table when the file is absent.
local function project_launch_configs()
  local f = io.open(".dap/launch.json", "r")
  if not f then
    return {}
  end

  local content = f:read("*a")
  f:close()

  local ok, data = pcall(vim.json.decode, content)
  if not ok or type(data) ~= "table" or not data.configurations then
    return {}
  end

  -- Map launch.json types to dap adapter names.
  local type_map = { debugpy = "python" }
  for _, config in ipairs(data.configurations) do
    config.type = type_map[config.type] or config.type
  end

  return data.configurations
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Virtual text for the debugger.
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      -- Minimal debugger view. It opens when a session starts and
      -- closes when the session ends.
      {
        "igorlfs/nvim-dap-view",
        version = "1.*",
        opts = { auto_toggle = false },
        keys = {
          {
            "<leader>du",
            function()
              require("dap-view").toggle()
            end,
            desc = "Toggle DAP View",
          },
        },
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dv", function() require("nvim-dap-virtual-text").toggle() end, desc = "Toggle Virtual Text" },
      { "<leader>dF", function() require("util.dap_config").create_fastapi() end, desc = "Create FastAPI DAP config" },
    },

    config = function()
      local dap = require("dap")

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- Read DAP configs from a VS Code `.vscode/launch.json` file.
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- Read DAP configs from a project-local `.dap/launch.json` file.
      dap.providers.configs["project-launch"] = project_launch_configs
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "debugpy" } },
  },
}
