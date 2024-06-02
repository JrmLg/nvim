return {
	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",
	-- See `:help ibl`
	main = "ibl",
	opts = {},

	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#485071" })
			vim.api.nvim_set_hl(0, "IndentBlanklineIndent", { fg = "#2C3448" })
		end)

		require("ibl").setup({
			indent = {
				highlight = "IndentBlanklineIndent",
				char = "│",
			},
			scope = {
				highlight = "CurrentScope",
				show_start = false,
			},
			exclude = { filetypes = {
				"startify",
			} },
		})
	end,
}
