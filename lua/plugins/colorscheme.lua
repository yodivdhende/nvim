return {
  {
    -- Angular-inspired custom colorscheme (local)
    name = "angular",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "angular",
    },
  },
}
