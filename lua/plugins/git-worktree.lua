return {
  "mitubaEX/git_worktree.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("git_worktree").setup({
      cleanup_buffers = true, -- Clean up old buffers when switching
      warn_unsaved = true, -- Warn about unsaved changes
      update_buffers = true, -- Update buffer paths to new worktree
      copy_envrc = true, -- Copy .envrc file to new worktrees (direnv)
      worktree_dir = ".worktrees", -- Directory for aggregating worktrees
    })
    require("telescope").load_extension("git_worktree")
  end,
}
