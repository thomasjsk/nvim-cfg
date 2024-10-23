return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require('rose-pine').setup({
            variant = "moon",
			disable_background = true,
			styles = {
				italic = false,
			},
		})
		vim.cmd("colorscheme rose-pine")
	end
}
