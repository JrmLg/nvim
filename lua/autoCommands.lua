vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		require("myFunctions").saveLastReg()
	end,
	desc = "Increment registers when yank.",
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "quickfix" },
	command = "nnoremap <buffer> <CR> <CR>",
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "setlocal formatoptions=cnrqjl",
	desc = "Overwrite ftplugin for formatoptions.",
})

vim.api.nvim_create_autocmd({ "BufEnter", "Filetype" }, {
	pattern = { "git" },
	command = "setlocal foldmethod=syntax | setlocal foldlevel=1",
	desc = "Enable folding for git commits.",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	command = 'if !bufexists("[Command Line]") && mode() != "c" | checktime | endif',
})

vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
	command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
	desc = "Display message when file changed.",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.ejs" },
	command = "setlocal filetype=ejs.html",
	desc = "Set filetype for ejs files.",
})

-- Relative line numbers
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	desc = "Set relative line numbers in normal mode and absolute in insert mode.",
	-- pattern = { "*" },
	command = "if &nu && mode() != 'i' | set rnu | endif",
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	desc = "Set absolute line numbers in insert mode and relative in normal mode.",
	-- pattern = { "*" },
	command = "if &nu | set nornu | endif",
})

-- vim.keymap.set("n", ":", function()
-- 	vim.cmd("set nornu")
-- 	vim.cmd(":")
-- end, {
-- 	expr = true,
-- 	silent = false,
-- 	noremap = true,
-- 	desc = "A short description",
-- })
--
-- vim.keymap.set("n", ":", "'<cmd>set nornu<cr>' . ':' ", {
-- 	expr = true,
-- 	silent = false,
-- 	noremap = true,
-- 	desc = "A short description",
-- })
