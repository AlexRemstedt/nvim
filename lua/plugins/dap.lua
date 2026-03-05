-- lua/plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      dap.providers.configs["project-launch"] = function(bufnr)
        local path = ".dap/launch.json"
        local f = io.open(path, "r")
        if not f then
          return {}
        end

        local content = f:read("*a")
        f:close()

        local data = vim.json.decode(content)
        if not data or not data.configurations then
          return {}
        end

        -- Map launch.json types to dap adapter names
        local type_map = { debugpy = "python" }
        for _, config in ipairs(data.configurations) do
          config.type = type_map[config.type] or config.type
        end

        return data.configurations
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = false,
  },
}
