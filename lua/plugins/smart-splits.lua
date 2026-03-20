return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.smart_splits_multiplexer_integration = "tmux"
  end,
  config = function()
    require("smart-splits").setup({
      multiplexer_integration = "tmux",
    })
    -- recommended mappings
    -- resizing splits
    -- these keymaps will also accept a range,
    -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
    vim.keymap.set("n", "<M-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<M-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<M-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<M-l>", require("smart-splits").resize_right)
    -- moving between splits
    vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
    -- swapping buffers between windows
    vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
  end,
}
