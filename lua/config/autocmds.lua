-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.cmd("command! W w")

-- Keep cursor centered in diff mode
local function sync_diff_scrolloff()
  if vim.wo.diff then
    if vim.w.diff_saved_scrolloff == nil then
      vim.w.diff_saved_scrolloff = vim.wo.scrolloff
    end
    vim.wo.scrolloff = 999
  elseif vim.w.diff_saved_scrolloff ~= nil then
    vim.wo.scrolloff = vim.w.diff_saved_scrolloff
    vim.w.diff_saved_scrolloff = nil
  end
end

vim.api.nvim_create_autocmd({ "OptionSet" }, {
  pattern = "diff",
  callback = sync_diff_scrolloff,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "VimEnter" }, {
  callback = sync_diff_scrolloff,
})

-- Auto-restore persistence session on startup if no files were passed as args
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("persistence").load()
    end
  end,
  nested = true,
})
