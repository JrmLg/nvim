return {
	"mhinz/vim-startify",

	config = function()
		vim.g.startify_fortune_use_unicode = 1
		vim.g.startify_session_dir = vim.fn.stdpath("config") .. "/sessions"
		vim.g.startify_session_before_save = { 'lua require("myFunctions").beforeStartifySave()' }
		vim.g.startify_lists = {
			{ type = "sessions", header = { "   Sessions" } },
			{ type = "files", header = { "   Files" } },
			{ type = "dir", header = { "   Directory : " .. vim.fn.getcwd() } },
			{ type = "bookmarks", header = { "   Bookmarks" } },
		}

		-- " \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
		-- " \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
		-- " \ { 'type': 'commands',  'header': ['   Commands']       },
		--
		vim.g.startify_bookmarks = {}

		local isModuleAvailable = require("myFunctions").isModuleAvailable
		if isModuleAvailable("bookmarks") then
			require("bookmarks")
		end
		vim.g.startify_bookmarks = vim.fn.extend(vim.g.startify_bookmarks, {
			{ nvim = vim.fn.stdpath("config") },
			{ vim = vim.fn.stdpath("config") },
		})
		--
		-- " https://patorjk.com/software/taag/#p=display&v=0&f=Ogre&t=NeoVim
		local header = {
			"              __                _                    ",
			"           /\\ \\ \\___  ___/\\   /(_)_ __ ___           ",
			"          /  \\/ / _ \\/ _ \\ \\ / / | '_ ` _ \\          ",
			"         / /\\  /  __/ (_) \\ V /| | | | | | |         ",
			"         \\_\\ \\/ \\___|\\___/ \\_/ |_|_| |_| |_|         ",
		}

		local tips = vim.fn["startify#fortune#boxed"]()
		for _, v in ipairs(tips) do
			table.insert(header, v)
		end

		vim.g.startify_custom_header = header

		vim.g.filtename_to_close = {}
		vim.g.buftype_to_close = { "help", "nofile", "terminal", "quickfix", "prompt", "popup", "preview" }
		vim.g.filtetype_to_close = { "coc-explorer", "fugitiveblame", "NvimTree", "neo-tree" }

		-- " If startify open a directory, file explorer is open instead of netrw
		vim.api.nvim_create_augroup("MyFileExplorer", {})
		vim.api.nvim_clear_autocmds({ group = "MyFileExplorer" })
		vim.api.nvim_create_autocmd("VimEnter", {
			desc = "Open my file explorer instead of netrw.",
			group = "MyFileExplorer",
			command = "sil! au! FileExplorer *",
		})
	end,
}
