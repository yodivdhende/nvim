return {
  -- add gruvbox
  { "erizocosmico/vim-firewatch" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "firewatch",
    },
  },
}
