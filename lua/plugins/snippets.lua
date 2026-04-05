return {
  "saghen/blink.cmp",
  opts = {
    snippets = {
      preset = "default",
      paths = function()
        return { vim.fn.stdpath("config") .. "/lua/snippets" }
      end,
    },
  },
}
