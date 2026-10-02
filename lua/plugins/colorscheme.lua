return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "shusia"
      vim.g.sonokai_transparent_background = 1
      vim.cmd("colorscheme sonokai")

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "sonokai",
        callback = function()
          vim.api.nvim_set_hl(0, "Visual", { bg = "#77859e" })
          vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#77859e" })
          vim.api.nvim_set_hl(0, "LineNr", { fg = "#9a8fa8" })
          vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e8e4ec", bold = true })
        end,
      })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#77859e" })
      vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#77859e" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#9a8fa8" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e8e4ec", bold = true })
    end,
  },

  -- Configure LazyVim to load the custom angular scheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
