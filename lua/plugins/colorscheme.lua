return {
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = true -- transparent
      vim.g.nord_italic = true
      vim.g.nord_bold = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_cursor_line_number_background = true
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
