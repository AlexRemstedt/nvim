return {
  "obsidian-nvim/obsidian.nvim",
  enabled = false,
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "personal",
        path = "~/proj/obsidian-wiki/",
      },
    },
  },
}
