------------------------------ Basic mappings ------------------------------
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", {
	silent = true,
	noremap = true,
	desc = "Disable space key.",
})
vim.keymap.set("n", "§", function()
	vim.o.list = not vim.o.list
end, {
	silent = true,
	noremap = true,
	desc = "Disable space key.",
})
vim.keymap.set("i", "<C-l>", "<Nop>", {
	silent = true,
	noremap = true,
	desc = "Disable Ctrl-l in insert mode.",
})
vim.keymap.set("n", "n", "nzzzv", {
	silent = false,
	noremap = true,
	desc = "Center the screen after search next.",
})
vim.keymap.set("n", "N", "Nzzzv", {
	silent = false,
	noremap = true,
	desc = "Center the screen after search next.",
})

------------- Remap for dealing with word wrap in normal mode --------------
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
	silent = true,
	noremap = true,
	expr = true,
})
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
	silent = true,
	noremap = true,
	expr = true,
})

------------------ Reload mapping without restarting nvim ------------------
vim.keymap.set("n", "<Leader><Leader>c", ":w<CR>:source %<CR>", {
	silent = false,
	noremap = true,
	desc = "Sour[C]e a vim script.",
})
vim.keymap.set("n", "<Leader><Leader>l", ":w<CR>:luafile %<CR>", {
	silent = false,
	noremap = true,
	desc = "Source a [L]uafile.",
})

------------------------ Open a command line window ------------------------
vim.keymap.set("n", "<BS>a", function()
	require("myFunctions").openCmdLine("")
end, {
	silent = true,
	noremap = true,
	desc = "Open a command line window.",
})

---------- Change normal key binding because of conflic with tab -----------
vim.keymap.set("n", "<C-p>", "<C-i>", {
	silent = false,
	noremap = true,
	desc = "Change the default mapping C-i to C-p.",
})

------------------------ Switching between buffers -------------------------
vim.keymap.set("n", "<S-TAB>", ":bprev<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the next buffer.",
})
vim.keymap.set("n", "<TAB>", ":bnext<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the previous buffer.",
})

-------------------------- Switching between tabs --------------------------
vim.keymap.set("n", "<C-TAB>", ":tabnext<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the next [T]ab.",
})
vim.keymap.set("n", "<C-S-TAB>", ":tabprevious<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the previous [T]ab.",
})
vim.keymap.set("n", "<Leader>tt", "<C-w>s<C-w>T", {
	silent = true,
	noremap = true,
	desc = "Set the current buffer in a new [T]ab.",
})
vim.keymap.set("n", "<Leader>tn", ":tabnew<CR>", {
	silent = true,
	noremap = true,
	desc = "Open a [N]ew [T]ab.",
})
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>", {
	silent = true,
	noremap = true,
	desc = "[C]lose a the current [T]ab.",
})

---------------------- Alternate way to save and quit ----------------------
vim.keymap.set("n", "<C-Q>", ":w <bar> bd<CR>", {
	silent = false,
	noremap = true,
	desc = "Save the current buffer and [Q]uit.",
})
vim.keymap.set("n", "<C-c>", ":bp|:bd #<CR>", {
	silent = true,
	noremap = true,
	desc = "Save the current buffer and [C]lose.",
})

------------------------------ Better tabbing ------------------------------
vim.keymap.set("v", "<", "<gv", {
	silent = false,
	noremap = true,
	desc = "Stay in visual mode after tabbing.",
})
vim.keymap.set("v", ">", ">gv", {
	silent = false,
	noremap = true,
	desc = "Stay in visual mode after tabbing.",
})

------------------------ Better window organisation ------------------------
vim.keymap.set("n", "<M-S-h>", "<C-w>H", {
	silent = false,
	noremap = true,
	desc = "Put the current window on left.",
})
vim.keymap.set("n", "<M-S-j>", "<C-w>J", {
	silent = false,
	noremap = true,
	desc = "Put the current window on down.",
})
vim.keymap.set("n", "<M-S-k>", "<C-w>K", {
	silent = false,
	noremap = true,
	desc = "Put the current window on up.",
})
vim.keymap.set("n", "<M-S-l>", "<C-w>L", {
	silent = false,
	noremap = true,
	desc = "Put the current window on right.",
})

------------------------- Better window navigation -------------------------
vim.keymap.set("n", "<M-h>", "<C-w>h", {
	silent = false,
	noremap = true,
	desc = "Go to the left window.",
})
vim.keymap.set("n", "<M-j>", "<C-w>j", {
	silent = false,
	noremap = true,
	desc = "Go to the down window.",
})
vim.keymap.set("n", "<M-k>", "<C-w>k", {
	silent = false,
	noremap = true,
	desc = "Go to the up window.",
})
vim.keymap.set("n", "<M-l>", "<C-w>l", {
	silent = false,
	noremap = true,
	desc = "Go to the right window.",
})

-------------------------- Better window resizing --------------------------
vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>", {
	silent = true,
	noremap = true,
	desc = "Resize the current window.",
})
vim.keymap.set("n", "<C-j>", ":resize +2<CR>", {
	silent = true,
	noremap = true,
	desc = "Resize the current window.",
})
vim.keymap.set("n", "<C-k>", ":resize -2<CR>", {
	silent = true,
	noremap = true,
	desc = "Resize the current window.",
})
vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>", {
	silent = true,
	noremap = true,
	desc = "Resize the current window.",
})

------------------------- Better window splitting --------------------------
vim.keymap.set("n", "<Leader>i", ":vsplit<CR>", {
	silent = true,
	noremap = true,
	desc = "Vert[I]cal split window.",
})
vim.keymap.set("n", "<Leader>h", ":split<CR>", {
	silent = true,
	noremap = true,
	desc = "[H]orizontal split window.",
})

-------------------------- Better git navigation ---------------------------
vim.keymap.set("n", "<Leader>gg", ":vertical Git<CR>", {
	silent = true,
	noremap = true,
	desc = "Show the [G]it panel.",
})
vim.keymap.set("n", "<Leader>g", ":Gitsigns preview_hunk_inline<CR>", {
	silent = true,
	noremap = true,
	desc = "Preview the [G]it hunk.",
})
vim.keymap.set("n", ")", ":Gitsigns next_hunk<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the next hunk git.",
})
vim.keymap.set("n", "(", ":Gitsigns prev_hunk<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the prev hunk git.",
})
vim.keymap.set("n", "<Leader>gr", ":Gitsigns reset_hunk<CR>", {
	silent = true,
	noremap = true,
	desc = "[G]it [R]este the git hunk.",
})
vim.keymap.set("n", "<Leader>gR", ":Gitsigns reset_buffer<CR>", {
	silent = true,
	noremap = true,
	desc = "[G]it [R]este the buffer.",
})
vim.keymap.set("n", "<Leader>gd", ":Gitsigns toggle_deleted<CR>", {
	silent = true,
	noremap = true,
	desc = "[G]it show [D]eleted lines.",
})
vim.keymap.set("n", "<Leader>gl", ":Gclog<CR>", {
	silent = true,
	noremap = true,
	desc = "[G]it show [L]og.",
})
vim.keymap.set("n", "<Leader>gb", ":G blame<CR>", {
	silent = true,
	noremap = true,
	desc = "[G]it show [B]lame.",
})

----------------------------- Escape terminal ------------------------------
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", {
	silent = false,
	noremap = true,
	desc = "[E]sc the terminal.",
})

------------- For compute math in insert mode and visual mode --------------
vim.keymap.set("i", "<C-e>", '<ESC>:lua require("myFunctions").selectMathExpression()<CR>c<C-r>=<C-r>"<CR>', {
	silent = false,
	noremap = true,
	desc = "Compute a mathematical expression.",
})
vim.keymap.set("n", "<C-e>", ':lua require("myFunctions").selectMathExpression()<CR>c<C-r>=<C-r>"<CR><ESC>', {
	silent = false,
	noremap = true,
	desc = "Compute a mathematical expression.",
})
vim.keymap.set("v", "<C-e>", 'c<C-r>=<C-r>"<CR>', {
	silent = false,
	noremap = true,
	desc = "Compute a mathematical expression.",
})

------------------------ Mapping for file explorer -------------------------
vim.keymap.set("n", "<Leader><TAB>", ":Neotree toggle reveal_force_cwd<cr>", {
	silent = true,
	noremap = true,
	desc = "Open the file tree explorer.",
})

----------------------------- Windows shortcut -----------------------------
vim.keymap.set("n", "<C-S>", ":write<CR>", {
	silent = true,
	noremap = true,
	desc = "[S]ave the current buffer.",
})
vim.keymap.set("i", "<C-S>", "<ESC>:write<CR>a", {
	silent = true,
	noremap = true,
	desc = "[S]ave the current buffer.",
})
vim.keymap.set("v", "<C-S>", ":write<CR>", {
	silent = true,
	noremap = true,
	desc = "[S]ave the current buffer.",
})
vim.keymap.set("v", "<C-X>", '"+x', {
	silent = false,
	noremap = true,
	desc = "Cut the current selection put in clipboard.",
})
vim.keymap.set("v", "<C-C>", '"+y', {
	silent = false,
	noremap = true,
	desc = "[C]opy the current selection.",
})
vim.keymap.set("c", "<C-V>", "<C-R>*", {
	silent = false,
	noremap = true,
	desc = "Paste the clipboard.",
})
vim.keymap.set("i", "<C-V>", '<ESC>:set paste<CR>"*p:set nopaste<CR>a', {
	silent = true,
	noremap = true,
	desc = "Paste the clipboard.",
})
vim.keymap.set("i", "<C-A>", "<ESC>ggVG", {
	silent = false,
	noremap = true,
	desc = "Select [A]ll the buffer.",
})
vim.keymap.set("v", "<C-A>", "<ESC>ggVG", {
	silent = false,
	noremap = true,
	desc = "Select [A]ll the buffer.",
})
vim.keymap.set("i", "<C-BS>", "<C-w>", {
	silent = false,
	noremap = true,
	desc = "Delete the previous word.",
})
vim.keymap.set("c", "<C-BS>", "<C-w>", {
	silent = false,
	noremap = true,
	desc = "Delete the previous word.",
})
vim.keymap.set("i", "<C-DEL>", "<C-RIGHT><C-w>", {
	silent = false,
	noremap = true,
	desc = "Delete the next word.",
})
vim.keymap.set("c", "<C-DEL>", "<C-RIGHT><C-w><BS>", {
	silent = false,
	noremap = true,
	desc = "Delete the next word.",
})

--------------------------- Navigate in quickfix ---------------------------
vim.keymap.set("n", "ç", ":copen<CR>:cnext<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the next quickfix item.",
})
vim.keymap.set("n", "_", ":copen<CR>:cprev<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the previous quickfix item.",
})
vim.keymap.set("n", "<BS>ç", ":cnewer<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the next quickfix.",
})
vim.keymap.set("n", "<BS>_", ":cprevious<CR>", {
	silent = true,
	noremap = true,
	desc = "Go to the previous quickfix.",
})
vim.keymap.set("n", "<BS><ESC>", ":cclose<CR>", {
	silent = true,
	noremap = true,
	desc = "Close the quickfix.",
})

----------------- Diagnostic mapping for neovim lspconfig ------------------
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	silent = false,
	noremap = true,
	desc = "Go to previous diagnostic message",
})
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
	silent = false,
	noremap = true,
	desc = "Go to next diagnostic message",
})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
	silent = false,
	noremap = true,
	desc = "Open floating diagnostic message",
})
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
	silent = false,
	noremap = true,
	desc = "Open diagnostics list",
})

---------------------------- Easymotion mapping ----------------------------
vim.keymap.set({ "n", "v" }, "<DEL>", "<Plug>(easymotion-prefix)", {
	silent = false,
	noremap = false,
	desc = "Open the easymotion.",
})

-------------------------- Quickly launch a macro --------------------------
vim.keymap.set("v", "<Leader>q", ":g//norm @", {
	silent = false,
	noremap = true,
	desc = "Execute macro on lines that match last search.",
})
vim.keymap.set("v", "<Leader>a", ":norm @", {
	silent = false,
	noremap = true,
	desc = "Execute macro on each lines.",
})
