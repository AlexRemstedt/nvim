vim.keymap.set("n", "<leader>co", function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, { desc = "Organize Imports (ty)", buffer = true })
