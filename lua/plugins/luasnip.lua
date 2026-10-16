return {
  "L3MON4D3/LuaSnip",
  opts = function(_, opts)
    opts.enable_autosnippets = true
    opts.store_selection_keys = "<Tab>"

    -- In tex buffers <Tab> expands non-auto LaTeX Suite snippets before jumping.
    local snippet_forward = LazyVim.cmp.actions.snippet_forward
    LazyVim.cmp.actions.snippet_forward = function()
      if vim.bo.filetype == "tex" and require("latex_suite").expand() then
        return true
      end
      return snippet_forward()
    end
  end,
  config = function(_, opts)
    require("luasnip").setup(opts)
    require("latex_suite").load()
  end,
}
