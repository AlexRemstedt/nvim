-- lua/plugins/slime.lua
return {
  "jpalardy/vim-slime",
  ft = { "python", "quarto" },
  init = function()
    vim.g.slime_target = "tmux"
    vim.g.slime_default_config = {
      socket_name = "default",
      target_pane = "{last}",
    }
    vim.g.slime_python_ipython = 1
    vim.g.slime_dont_ask_default = 0
    vim.g.slime_cell_delimiter = "^```"
    vim.g.slime_no_mappings = false
  end,
  keys = {
    { "<leader>cc", "<Plug>SlimeSendCell", desc = "Slime send cell", mode = { "n", "x" } },
  },
}
