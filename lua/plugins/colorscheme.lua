return {
  {
    -- Angular-inspired custom colorscheme (local)
    name = "angular",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.angular_transparent = true
    end,
  },

  -- Configure LazyVim to load the custom angular scheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "angular",
    },
  },
}
