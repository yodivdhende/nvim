return {
  -- Let LazyVim manage mason/mason-lspconfig; just ensure servers are installed
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "svelte-language-server", "eslint-lsp", "html-lsp" })
    end,
  },

  -- Configure LSP servers via opts (LazyVim merges these cleanly)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			lspconfig.svelte.setup({
				capabilities = capabilities,
			})

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function()
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
				end
			})
		end
	},
    opts = {
      servers = {
        svelte = {},
        eslint = {},
        html = {},
      },
    },
  },
}
