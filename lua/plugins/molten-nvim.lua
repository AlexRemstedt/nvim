-- Jupyter notebook editing in Neovim
-- Optional: image.nvim for inline image support
-- Config is copied from https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md
return {
  {
    "benlubas/molten-nvim",
    lazy = true,
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_output_win_max_height = 20
    end,
    keys = {
      {
        "<leader>mi",
        function()
          vim.cmd("MoltenInit")
        end,
        desc = "Initialize Kernel",
      },
      {
        "<leader>ml",
        function()
          vim.cmd("MoltenEvaluateLine")
        end,
        desc = "Evaluate Line",
      },
      {
        "<leader>mc",
        function()
          vim.cmd("MoltenEvaluateOperator")
        end,
        desc = "Evaluate Cell",
      },
      {
        "<leader>mr",
        function()
          vim.cmd("MoltenReevaluateCell")
        end,
        desc = "Re-evaluate Cell",
      },
      { "<leader>mc", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", desc = "Evaluate Visual" },
      {
        "<leader>md",
        function()
          vim.cmd("MoltenDelete")
        end,
        desc = "Delete Cell",
      },
      {
        "<leader>mo",
        function()
          vim.cmd("noautocmd MoltenEnterOutput")
        end,
        desc = "Show Output",
      },
    },
  },
  {
    "quarto-dev/quarto-nvim",
    lazy = true,
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },
}
