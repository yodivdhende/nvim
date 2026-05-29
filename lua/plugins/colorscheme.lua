return {
  -- add nord
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- preserve the transparent background that gruvbox used
      vim.g.nord_disable_background = true
    end,
    config = function()
      vim.cmd("colorscheme nord")

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nord",
        callback = function()
          vim.api.nvim_set_hl(0, "Visual", { bg = "#77859e" })
          vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#77859e" })
        end,
      })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#77859e" })
      vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#77859e" })
    end,
  },

  -- Configure LazyVim to load nord
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
