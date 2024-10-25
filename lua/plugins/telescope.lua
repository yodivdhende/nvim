return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
			config =  function()
				local builtin = require('telescope.builtin')
				--vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
				--vim.keymap.set('n', '<C-S-p>', builtin.live_grep, { desc = 'Telescope live grep' })
				vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
				vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
				vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope list reference' })
			end,
}
