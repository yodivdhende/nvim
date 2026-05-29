return {
  --  {
  --    "scottmckendry/cyberdream.nvim",
  --    lazy = false,
  --    priority = 1000,
  --  },
  {
    "ficcdaf/ashen.nvim",
    -- optional but recommended,
    -- pin to the latest stable release:
    lazy = false,
    priority = 1000,
    -- configuration is optional!
    opts = {
      -- your settings here
    },
  },

  -- Configure LazyVim to load ashen
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ashen",
    },
  },
}
