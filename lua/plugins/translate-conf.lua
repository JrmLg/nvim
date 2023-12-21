return {
	"uga-rosa/translate.nvim",

	config = function()
		vim.keymap.set("v", "<Leader>t", ":Translate en<CR>", { noremap = true, desc = "[T]ranslate in english." })
		vim.keymap.set("v", "<Leader>tf", ":Translate fr<CR>", { noremap = true, desc = "[T]ranslate in french." })
		vim.keymap.set(
			"v",
			"<Leader>tr",
			":Translate en -output=replace<CR>",
			{ noremap = true, desc = "[T]ranslate and [R]eplace in english." }
		)
		vim.keymap.set(
			"v",
			"<Leader>trf",
			":Translate fr -output=replace<CR>",
			{ noremap = true, desc = "[T]ranslate and [R]eplace in french." }
		)
		vim.keymap.set(
			"v",
			"<Leader>ti",
			":Translate en -output=insert<CR>",
			{ noremap = true, desc = "[T]ranslate and [I]nsert in english." }
		)
		vim.keymap.set(
			"v",
			"<Leader>tif",
			":Translate fr -output=insert<CR>",
			{ noremap = true, desc = "[T]ranslate and [I]nsert in french." }
		)
	end,
}
