vim.o.textwidth = 80
vim.o.colorcolumn = "81"

vim.keymap.set("n", "<localleader>x", function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("%- %[ %]") then
    -- Unchecked -> Checked
    new_line = line:gsub("%- %[ %]", "- [X]", 1)
  elseif line:match("%- %[X%]") then
    -- Checked -> Unchecked
    new_line = line:gsub("%- %[X%]", "- [ ]", 1)
  else
    return
  end
  vim.api.nvim_set_current_line(new_line)
end, { desc = "Toggle markdown checkbox" })
