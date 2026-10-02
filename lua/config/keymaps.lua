-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim's default window nav keymaps with smart-splits (tmux-aware)
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- smart-splits: override LazyVim's default A-j/A-k "move line" mappings
-- so that Alt-j/Alt-k resize windows like Alt-h/Alt-l do
vim.keymap.set("n", "<M-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<M-k>", require("smart-splits").resize_up)
