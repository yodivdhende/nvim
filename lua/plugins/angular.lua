return {
  -- LazyVim's prettier extra only trusts a hardcoded filetype list; for
  -- anything else (including `htmlangular`) it probes availability by
  -- shelling out to a bare `prettier` binary on $PATH, which fails when only
  -- the project-local node_modules prettier exists. We explicitly opt
  -- `htmlangular` into prettier below, so skip that probe for it instead of
  -- silently reporting unavailable.
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["htmlangular"] = opts.formatters_by_ft["htmlangular"] or {}
      vim.list_extend(opts.formatters_by_ft["htmlangular"], { "prettier" })

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = opts.formatters.prettier or {}

      -- Prettier infers the plain `html` parser from the `.html` extension,
      -- which doesn't understand Angular's `@if`/`@for` control-flow syntax
      -- and mangles its indentation. Force the `angular` parser instead.
      opts.formatters.prettier.options = opts.formatters.prettier.options or {}
      opts.formatters.prettier.options.ft_parsers = opts.formatters.prettier.options.ft_parsers or {}
      opts.formatters.prettier.options.ft_parsers.htmlangular = "angular"

      local original_condition = opts.formatters.prettier.condition
      opts.formatters.prettier.condition = function(self, ctx)
        if vim.bo[ctx.buf].filetype == "htmlangular" then
          return true
        end
        return original_condition == nil or original_condition(self, ctx)
      end
    end,
  },
}
