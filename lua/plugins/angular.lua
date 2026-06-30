return {
  -- LazyVim's prettier extra only covers `html`, but Angular templates use
  -- the `htmlangular` filetype — add it explicitly.
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["htmlangular"] = opts.formatters_by_ft["htmlangular"] or {}
      vim.list_extend(opts.formatters_by_ft["htmlangular"], { "prettier" })
    end,
  },
}
