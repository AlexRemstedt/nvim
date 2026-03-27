-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.opt.showtabline = 0
vim.opt.splitkeep = "cursor"
vim.opt.wrap = true
vim.opt.exrc = true

-- Molten Nvim options
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/python3")
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_auto_open_output = true
vim.g.molten_wrap_output = true
vim.g.molten_output_show_more = true
