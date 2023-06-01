
" ------------------ Reload mapping without restarting nvim ------------------
nnoremap <Leader><Leader>r :source $MYVIMRC<CR>
nnoremap <Leader><Leader>c :source %<CR>
nnoremap <Leader><Leader>l :luafile %<CR>

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

" ----------------------- Move cursor in command-line ------------------------
cnoremap <M-l> <right>
cnoremap <M-h> <left>
cnoremap <M-j> <down>
cnoremap <M-k> <up>
cnoremap <M-H> <C-o>^
cnoremap <M-L> <C-o>$

" -------------------------- Change window opacity ---------------------------
" nnoremap <M-t> :call AlacrittyChangeOpacity()<CR>
" nnoremap <M-T> :call AlacrittySetOpacityValue(0.04)<CR>
" nnoremap <M-+> :call AlacrittyIncreaseOpacity(0.02)<CR>
" nnoremap <M--> :call AlacrittyDecreaseOpacity(0.02)()<CR>

" ---------- Change normal key binding because of conflic with tab -----------
nnoremap <C-p> <C-i>
nnoremap <CSI><C-S-P> :echo "Salut Ctrl+Shift+P"<CR>

" ------------------------ Switching between buffers -------------------------
nnoremap <silent><S-TAB> :bprev<CR>
nnoremap <silent><TAB> :bnext<CR>

" -------------------------- Switching between tabs --------------------------
nnoremap <silent> <Leader>th :tabprevious<CR>
nnoremap <silent> <Leader>tl :tabnext<CR>
nnoremap <silent> <Leader>tt :tab split<CR>
nnoremap <silent> <Leader>tn :tabnew<CR>
nnoremap <silent> <Leader>tc :tabclose<CR>

" --------------------------- Test binding special ---------------------------
nnoremap <C-S-p> :echo "Shortcut work."
" nnoremap <C-S-P> :echo "Ok mapping for C-S-P work in nvim !"<CR>
" nnoremap <ESC>80;6u :echo "bonjour toi 0!"<CR>
" nnoremap <ESC>[80;6u :echo "bonjour toi 1!"<CR>
" nnoremap <ESC-80;6u> :echo "bonjour toi 2!"<CR>
" nnoremap <ESC><C-S-P> :echo "bonjour toi 3!"<CR>
" nnoremap <ESC><C-S-P> :echo "bonjour toi 3!"<CR>
" nnoremap <CSI>80;6u :echo "bonjour toi 3!"<CR>
" nnoremap ^[H :echo "bonjour toi 5"<CR>
" noremap ^[[105;5~ <C-I>
" nnoremap <C-I> :echo "ok"<CR>
" nnoremap ^[[105;5~ :echo "bonjour"<CR>
 

" -------------------------- Alternate way to save ---------------------------
nnoremap <C-s :w<CR>
" ---------------------- Alternate way to save and quit ----------------------
nnoremap <C-q> :w <bar> bd<CR>
" -------------- Alternate way to close buffer and keep window ---------------
nnoremap <silent><C-c> :bp\|:bd #<CR>


" ---------------------------- Tab for completion ----------------------------
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


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


" --------------------- Overwrite settings of alacritty ----------------------
noremap <C-v> <C-v>
noremap <C-a> <C-a>

" ---------------------- Use vv for escape visual mode -----------------------
vnoremap vv <Esc> 

" ----------------------------- Escape terminal ------------------------------
tnoremap <Leader><TAB> <C-\><C-n>

" ------------- For compute math in insert mode and visual mode --------------
inore <C-e> <ESC>:call SelectMathExpression()<CR>c<C-r>=<C-r>"<CR>
nnore <C-e> :call SelectMathExpression()<CR>c<C-r>=<C-r>"<CR><ESC>
vnore <C-e> c<C-r>=<C-r>"<CR>


" ------------------------------ Debugging keys ------------------------------
"
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
" nnoremap <silent> <Leader><TAB> :call OpenCocExplorerWithoutAnimation()<CR>



