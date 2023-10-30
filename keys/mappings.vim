
" ------------------ Reload mapping without restarting nvim ------------------
nnoremap <Leader><Leader>r :source $MYVIMRC<CR>
nnoremap <Leader><Leader>c :w<CR>:source %<CR>
nnoremap <Leader><Leader>l :w<CR>:luafile %<CR>

" ---------- Change normal key binding because of conflic with tab -----------
nnoremap <C-p> <C-i>

" ------------------------ Switching between buffers -------------------------
nnoremap <silent><S-TAB> :bprev<CR>
nnoremap <silent><TAB> :bnext<CR>

" -------------------------- Switching between tabs --------------------------
nnoremap <silent> <C-TAB> :tabnext<CR>
nnoremap <silent> <C-S-TAB> :tabprevious<CR>
nnoremap <silent> <Leader>tt <C-w>s<C-w>T
nnoremap <silent> <Leader>tn :tabnew<CR>
nnoremap <silent> <Leader>tc :tabclose<CR>

" ---------------------- Alternate way to save and quit ----------------------
nnoremap <C-Q> :w <bar> bd<CR>
" -------------- Alternate way to close buffer and keep window ---------------
nnoremap <silent><C-c> :bp\|:bd #<CR>

" ------------------------------ Better tabbing ------------------------------
vnoremap < <gv
vnoremap > >gv

" ------------------------ Better window organisation ------------------------
nnoremap <M-S-h> <C-w>H
nnoremap <M-S-j> <C-w>J
nnoremap <M-S-k> <C-w>K
nnoremap <M-S-l> <C-w>L

" ------------------------- Better window navigation -------------------------
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" -------------------------- Better window resizing --------------------------
nnoremap <silent><C-h>    :vertical resize -2<CR>
nnoremap <silent><C-j>    :resize +2<CR>
nnoremap <silent><C-k>    :resize -2<CR>
nnoremap <silent><C-l>    :vertical resize +2<CR>

" ------------------------- Better window splitting --------------------------
nmap <silent><Leader>i :vsplit<CR>
nmap <silent><Leader>h :split<CR>

" -------------------------- Better git navigation ---------------------------
nnoremap <silent><Leader>gg :vertical Git<CR>
nnoremap <silent><Leader>g :Gitsigns preview_hunk_inline<CR>
nnoremap <silent>) :Gitsigns next_hunk<CR>
nnoremap <silent>( :Gitsigns prev_hunk<CR>
nnoremap <silent><Leader>gr :Gitsigns reset_hunk<CR>
nnoremap <silent><Leader>gR :Gitsigns reset_buffer<CR>
nnoremap <silent><Leader>gd :Gitsigns toggle_deleted<CR>
nnoremap <silent><Leader>gl :Gclog<CR>
nnoremap <silent><Leader>gb :G blame<CR>

" ----------------------------- Escape terminal ------------------------------
tnoremap <ESC> <C-\><C-n>

" ------------- For compute math in insert mode and visual mode --------------
inore <C-e> <ESC>:call SelectMathExpression()<CR>c<C-r>=<C-r>"<CR>
nnore <C-e> :call SelectMathExpression()<CR>c<C-r>=<C-r>"<CR><ESC>
vnore <C-e> c<C-r>=<C-r>"<CR>

" ------------------------------ Debugging keys ------------------------------
nnoremap <F5> :lua require('dap').continue()<CR>
nnoremap <F4> :lua require('dap').step_out()<CR>
nnoremap <F3> :lua require('dap').step_over()<CR>
nnoremap <F2> :lua require('dap').step_into()<CR>
nnoremap <Leader>b :lua require('dap').toggle_breakpoint()<CR>
nnoremap <expr> <Leader>db ":lua require('dap').set_breakpoint(" . input('Breakpoint condition : ') . ")<CR>"
nnoremap <expr> <Leader>dm ":lua require('dap').set_breakpoint(nil, nil, \"" . input('Log message : ') . "\")<CR>"
nnoremap <Leader>dr :lua require('dap').repl.open()<CR>
nnoremap <Leader>du :lua require('dapui').open()<CR>

" ------------------------ Mapping for file explorer -------------------------
nnoremap <silent> <Leader><TAB> :Neotree toggle reveal_force_cwd<cr>

" ----------------------------- Windows shortcut -----------------------------
nnoremap <silent><C-S> :write<CR>
inoremap <silent><C-S> <ESC>:write<CR>a
vnoremap <silent><C-S> :write<CR>
vnoremap <C-X> "+x
vnoremap <C-C> "+y
cnoremap <C-V> <C-R>*
inoremap <silent><C-V> <ESC>:set paste<CR>"*p:set nopaste<CR>a
nnoremap <C-A> ggVG
inoremap <C-A> <ESC>ggVG
vnoremap <C-A> <ESC>ggVG
inoremap <C-BS> <C-w>
cnoremap <C-BS> <C-w>
inoremap <C-DEL> <C-RIGHT><C-w>
cnoremap <C-DEL> <C-RIGHT><C-w><BS>

" --------------------------- Navigate in quickfix ---------------------------
nnoremap <silent>ç :copen<CR>:cnext<CR>
nnoremap <silent>_ :copen<CR>:cprev<CR>
nnoremap <silent><BS>ç :cprevious<CR>
nnoremap <silent><BS>_ :cnewer<CR>
nnoremap <silent><BS><ESC> :cclose<CR>

" -------------------------- Quickly launch a macro --------------------------
vnoremap <Leader>q :g//norm @
vnoremap <Leader>a :norm @
