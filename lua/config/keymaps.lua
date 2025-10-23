-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit -v<cr>", { desc = "Git Commit" })
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>GG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (Root Dir)" })
end
