return {
	"nvimtools/none-ls.nvim",
	dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			source = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.djlint,
				null_ls.builtins.diagnostics.djlint,
				require("none-ls.diagnostics.eslint_d"),
			}
		})
		vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
	end
}
