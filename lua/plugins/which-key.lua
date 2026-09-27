return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.replace = opts.replace or {}
      opts.replace.desc = opts.replace.desc or {}
      -- which-key's built-in rule for `<Plug>(name)` is greedy and leaves
      -- the trailing `)` in the label; this fixes it with a lazy match.
      opts.replace.desc[1] = { "<Plug>%(?(.-)%)?$", "%1" }
    end,
  },
}
