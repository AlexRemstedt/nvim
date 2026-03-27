-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "j")
vim.keymap.del("n", "k")

vim.keymap.set("n", "<leader>gc", "<cmd>Git commit -v<cr>", { desc = "Git Commit" })
vim.keymap.set("n", "<leader>ga", "<cmd>Git commit --amend<cr>", { desc = "Git amend" })
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>GG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (Root Dir)" })
end
