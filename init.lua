require("settings")
require("mapping")
require("myCommands")

-- Install package manager
--     https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--     You can configure plugins using the `config` key.
--
--     You can also configure plugins after the setup call,
--     as they will be available in your neovim runtime.
require("lazy").setup({
	-- NOTE: First, some plugins that don't require any configuration

	"ThePrimeagen/vim-be-good",

	-- [[ Git plugins ]]
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	"vim-scripts/ReplaceWithRegister", -- Automatically disables search highlighting
	"romainl/vim-cool", -- Draw cursor line only on current window
	"inkarkat/vim-CursorLineCurrentWindow", -- Add some text objects
	"wellle/targets.vim", -- Closing tag in javascript React
	"windwp/nvim-ts-autotag",

	-- [[ Navigation helpers ]]
	"easymotion/vim-easymotion", -- Jump in editor
	"justinmk/vim-sneak", -- Jump in line with two letter

	{ "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

	{ "folke/which-key.nvim", opts = {} }, -- Useful plugin to show you pending keybinds.

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
				move_cursor = false,
			})
		end,
	},

	{ import = "plugins" },
}, {})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- document existing key chains
require("which-key").register({
	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})
