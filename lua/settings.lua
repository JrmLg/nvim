vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.cmd.syntax 'enable'

vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.wrap = false -- Display long lines as just one line
vim.o.encoding = "utf-8" -- The encoding displayed
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.ruler = true -- Show the cursor position all the time
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.iskeyword = vim.o.iskeyword .. ",-" -- " treat dash separated words as a word text object"
vim.o.mouse = "a" -- Enable your mouse
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.t_Co = 256 -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.o.tabstop = 4 -- Insert 4 spaces for a tab
vim.o.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.o.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.o.expandtab = true -- Converts tabs to spaces
vim.o.smartindent = true -- Makes indenting smart
vim.o.laststatus = 0 -- Always display the status line
vim.wo.number = true -- Line numbers
vim.o.cursorline = true -- Enable highlighting of the current line
vim.o.background = "dark" -- tell vim what the background color looks like
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.updatetime = 250 -- Faster completion
vim.o.timeoutlen = 300 -- By default timeoutlen is 1000 ms
vim.o.textwidth = 80
vim.o.autoindent = true -- Good auto indent
vim.o.formatoptions = "cnrqjl" -- Stop newline continution of comments
vim.o.scrolloff = 6 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.incsearch = true -- While typing a search command, show where the pattern, as it was typed so far, matches.
vim.o.foldmethod = "indent" -- more indent means a higher fold level
vim.o.foldlevel = 9
vim.o.listchars = "tab:=>,eol:$"
vim.o.virtualedit = "onemore" -- Allow the cursor to move just past the end of the line
vim.o.selection = "inclusive"
vim.o.signcolumn = "yes"
vim.o.autoread = true
vim.o.listchars = vim.o.listchars .. ",space:."
-- vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.termguicolors = true -- NOTE: You should make sure your terminal supports this

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