return {
	"joeveiga/ng.nvim",
	config = function()
		local ng = require('ng')
		vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, {})
		vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, {})
		vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, {})
	end
}
