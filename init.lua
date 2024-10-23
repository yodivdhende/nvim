vim.cmd(":imap jj <esc>")
vim.cmd(":set relativenumber")
vim.cmd(":set tabstop=2")
vim.cmd(":set softtabstop=2")
vim.cmd(":set shiftwidth=2")

require("config.lazy")
require("lazy").setup("plugins")
