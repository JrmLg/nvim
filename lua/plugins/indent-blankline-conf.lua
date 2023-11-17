return {
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- See `:help ibl`
	main = "ibl",
	opts = {},

	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#587FC0" })
		end)

		require("ibl").setup({
			scope = { highlight = "CurrentScope" },
			exclude = { filetypes = {
				"startify",
			} },
		})
	end,
}
