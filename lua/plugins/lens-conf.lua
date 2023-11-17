return {
	"camspiers/lens.vim",

	dependencies = {
		"camspiers/animate.vim", -- resize screen with animation
		"joeytwiddle/sexy_scroller.vim", -- smooth scrolling
	},

	config = function()
		-- [[ Settings for lens.vim ]]
		vim.g["lens#disabled"] = 1
		vim.g["lens#animate"] = 1
		vim.g["lens#disabled_filetypes"] = { "figitiveblame", "coc-list*", "nerdtree", "coc-explorer", "fzf" }
		vim.g["len#disabled_buftypes"] = {}
		vim.g["len#disabled_filenames"] = {}
		vim.g["lens#height_resize_max"] = 35
		vim.g["len#height_resize_min"] = 6
		vim.g["len#width_resize_max"] = 100
		vim.g["len#width_resize_min"] = 8

		-- [[ Settings for animate.vim ]]
		vim.g.SexyScroller_ScrollTime = 10
		vim.g.SexyScroller_CursorTime = 5
		vim.g.SexyScroller_MaxTime = 500
		vim.g.SexyScroller_EasingStyle = 2

		vim.keymap.set("n", "<C-CR>", function()
			local cur_row = vim.fn.line(".")
			local cur_col = vim.fn.col(".")
			vim.fn.cursor({ cur_row, 1 })
			vim.cmd.redraw()
			vim.cmd("call lens#run()")
			vim.fn.cursor({ cur_row, cur_col })
		end, {
			desc = "Auto resize current screen.",
		})
	end,
}
