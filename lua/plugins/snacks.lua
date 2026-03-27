-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      transform = function(item)
        local path = item.file or item.text or ""
        local test_dirs = vim.g.picker_test_dirs or { "tests?", "spec" }

        for _, dir in ipairs(test_dirs) do
          if path:match("/" .. dir .. "/") then
            item.score_add = (item.score_add or 0) - 30
            break
          end
        end

        return item
      end,
      sources = {
        lsp_references = {
          matcher = {
            sort_empty = true, -- apply scoring even with no search query
          },
        },
      },
    },
  },
}
