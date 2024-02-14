return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		"zbirenbaum/copilot-cmp",
	},

	config = function()
		require("copilot_cmp").setup({
			event = { "InsertEnter", "TextChanged" },
			fix_pairs = true,
		})

		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
				keymap = {
					jump_prev = "(",
					jump_next = ")",
					accept = "l",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "right", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = "<M-m>",
					next = "<M-j>",
					prev = "<M-k>",
					dismiss = "<M-h>",
				},
			},
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 16.x
			server_opts_overrides = {},
		})
	end,
}
