return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		require("bufferline").setup()
		vim.cmd("call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)")
	end,
}
