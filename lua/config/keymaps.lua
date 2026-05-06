-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "j")
vim.keymap.del("n", "k")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
vim.keymap.set("n", "<M-j>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
vim.keymap.set("n", "<M-l>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

vim.keymap.del("n", "H")
vim.keymap.del("n", "L")

vim.keymap.set("n", "<leader>gc", "<cmd>Git commit -v<cr>", { desc = "Git Commit" })
vim.keymap.set("n", "<leader>ga", "<cmd>Git commit --amend<cr>", { desc = "Git Amend" })
if vim.fn.executable("lazygit") == 1 then
  vim.keymap.set("n", "<leader>GG", function()
    Snacks.lazygit()
  end, { desc = "Lazygit (Root Dir)" })
end
