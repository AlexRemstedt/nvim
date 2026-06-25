return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      if not configs.go_template_lsp then
        configs.go_template_lsp = {
          default_config = {
            cmd = { "go-template-lsp" },
            filetypes = { "gotmpl" },
            root_dir = require("lspconfig.util").root_pattern("go.mod", ".git"),
            settings = {},
          },
        }
      end
      opts.servers = opts.servers or {}
      opts.servers.go_template_lsp = {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gotmpl" })
    end,
  },
}
