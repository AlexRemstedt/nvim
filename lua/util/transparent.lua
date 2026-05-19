local M = {}

M.groups = { "Normal", "NormalNC", "NormalFloat", "FloatBorder", "SignColumn", "EndOfBuffer" }

function M.toggle()
  vim.g.transparent_bg = not vim.g.transparent_bg
  if vim.g.transparent_bg then
    for _, g in ipairs(M.groups) do
      local hl = vim.api.nvim_get_hl(0, { name = g })
      hl.bg = "none"
      hl.ctermbg = "none"
      vim.api.nvim_set_hl(0, g, hl)
    end
  else
    vim.cmd("colorscheme " .. vim.g.colors_name)
  end
end

return M
