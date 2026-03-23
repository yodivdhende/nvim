return {
  "vijhhh2/angular-switch.nvim",
  config = function()
    require("angular-switch").setup()
  end,
  keys = {
    { "<S-A-u>", "<cmd>AsSwitchToHtml<cr>", desc = "Angular Switch to  html" },
    { "<S-A-o>", "<cmd>AsSwitchToTs<cr>", desc = "Angular Switch to  typescript" },
    { "<S-A-i>", "<cmd>AsSwitchToStyles<cr>", desc = "Angular Switch to  styles" },
    { "<S-A-p>", "<cmd>AsSwitchToSpec<cr>", desc = "Angular Switch to  html" },
  },
}
