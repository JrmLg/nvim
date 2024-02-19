return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"

	config = function()
		local neogen = require("neogen")

		vim.keymap.set("n", "<leader>df", function()
			neogen.generate({ type = "func" })
		end, {
			silent = true,
			noremap = true,
			desc = "[D]ocument the current [F]unction.",
		})

		vim.keymap.set("n", "<leader>dc", function()
			neogen.generate({ type = "class" })
		end, {
			silent = true,
			noremap = true,
			desc = "[D]ocument the current [C]lass.",
		})

		vim.keymap.set("n", "<leader>dm", function()
			neogen.generate({ type = "file" })
		end, {
			silent = true,
			noremap = true,
			desc = "[D]ocument the current [M]odule.",
		})

		neogen.setup({
			-- snippet_engine = "luasnip",
		})
	end,
}
