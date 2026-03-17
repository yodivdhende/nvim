return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "angular", "typescript", "javascript" })
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {
      langs = {
        htmlangular = "<!-- %s -->",
      },
    },
  },
}
