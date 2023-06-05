
" ------------------ Reload mapping without restarting nvim ------------------
nnoremap <Leader><Leader>r :source $MYVIMRC<CR>
nnoremap <Leader><Leader>c :w<CR>:source %<CR>
nnoremap <Leader><Leader>l :w<CR>:luafile %<CR>

" ----------------------- Better nav for omnicomplete ------------------------
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" --------------------------- Move in insert mode ----------------------------
inoremap <M-l> <right>
inoremap <M-h> <left>
inoremap <M-j> <down>
inoremap <M-k> <up>
inoremap <M-H> <C-o>^
inoremap <M-L> <C-o>$

" ------------------------ Better command navigation -------------------------
cnoremap <M-l> <right>
cnoremap <M-h> <left>
cnoremap <M-j> <down>
cnoremap <M-k> <up>
cnoremap <M-H> <C-o>^
cnoremap <M-L> <C-o>$

" ---------- Change normal key binding because of conflic with tab -----------
nnoremap <C-p> <C-i>

" ------------------------ Switching between buffers -------------------------
nnoremap <silent><S-TAB> :bprev<CR>
nnoremap <silent><TAB> :bnext<CR>

" -------------------------- Switching between tabs --------------------------
nnoremap <silent> <Leader>th :tabprevious<CR>
nnoremap <silent> <Leader>tl :tabnext<CR>
nnoremap <silent> <Leader>tt :tab split<CR>
nnoremap <silent> <Leader>tn :tabnew<CR>
nnoremap <silent> <Leader>tc :tabclose<CR>

" -------------------------- Alternate way to save ---------------------------
nnoremap <C-s :w<CR>
" ---------------------- Alternate way to save and quit ----------------------
nnoremap <C-q> :w <bar> bd<CR>
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
nnoremap <silent><Leader>v :vsplit<CR>
nnoremap <silent><Leader>h :split<CR>

" -------------------------- Better git navigation ---------------------------
nnoremap <silent><Leader>gg :Git<CR>
nnoremap <silent><Leader>g :Gitsigns preview_hunk_inline<CR>
nnoremap <silent><Leader>gj :Gitsigns next_hunk<CR>
nnoremap <silent><Leader>gk :Gitsigns prev_hunk<CR>
nnoremap <silent><Leader>gr :Gitsigns reset_hunk<CR>
nnoremap <silent><Leader>gR :Gitsigns reset_buffer<CR>
nnoremap <silent><Leader>gd :Gitsigns toggle_deleted<CR>
nnoremap <silent><Leader>gl :Gclog<CR>
nnoremap <silent><Leader>gb :G blame<CR>

" ---------------------- Use vv for escape visual mode -----------------------
vnoremap vv <Esc> 

" ----------------------------- Escape terminal ------------------------------
tnoremap <Leader><TAB> <C-\><C-n>

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

" ------------------------- Mapping for coc explorer -------------------------
nnoremap <silent> <Leader><TAB> :CocCommand explorer<CR>

" ----------------------------- Windows shortcut -----------------------------
nnoremap <C-S> :update<CR>
inoremap <C-S> :update<CR>
vnoremap <C-S> :update<CR>
vnoremap <C-X> "+x
vnoremap <C-C> "+y
cnoremap <C-V> <C-R>*
inoremap <C-V> <C-R>*
inoremap <C-A> <ESC>ggvG
vnoremap <C-A> <ESC>ggvG

" -------------------------- Better code navigation --------------------------
nnoremap ** *
vnoremap ** *
nnoremap <silent>* :let last_win_pos=winsaveview()<CR>:keepjumps normal! mi*`i<CR>:call winrestview(last_win_pos)<CR>
vnoremap <silent>* :<C-w>let last_win_pos=winsaveview()<CR>:let @/=getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1]<CR>:keepjumps normal! mi//`i<CR>:call winrestview(last_win_pos)<CR>:set hls<CR>


