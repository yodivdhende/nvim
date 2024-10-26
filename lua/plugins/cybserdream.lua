return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme cyberdream")
		require("lualine").setup({
			options = {
				theme = "auto",
				borderless_telescope = true,
			},
		})
	end
}
