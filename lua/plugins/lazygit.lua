return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {
      config = {
        os = {
          -- the default "nvim-remote" preset uses --remote-tab; open in the current window instead
          edit = [[nvim --server "$NVIM" --remote {{filename}}]],
          editAtLine = [[nvim --server "$NVIM" --remote +{{line}} {{filename}}]],
          editAtLineAndWait = [[nvim --server "$NVIM" --remote +{{line}} {{filename}}]],
        },
      },
    },
  },
}
