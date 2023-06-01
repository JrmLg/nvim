
" ---------------------- Disable auto resizing windows -----------------------
" let g:lens#disabled = 1

" ---------------------------- Disable animation -----------------------------
let g:lens#animate = 0

let g:lens#disabled_filetypes = ['coc-list*', 'nerdtree', 'coc-explorer', 'fzf'] " , 'vim'
" let g:lens#disabled_buftypes = [] 
" let g:lens#disabled_filenames = []

let g:lens#height_resize_max = 35
let g:lens#height_resize_min = 6
let g:lens#width_resize_max = 100
let g:lens#width_resize_min = 8



" ---------------------------- Mapping pour lens -----------------------------
function AutoResizeCurrentScreen()
    let cur_row = line('.')
    let cur_col = col('.')
    call cursor(cur_row, 1)
    execute "redraw"
    call lens#run()
    call cursor(cur_row, cur_col)
endfunction

" function TestLens()
"     let ft = &filetype
"     let bt = &buftype
"     let fn = expand('%:t')

"     call setreg('a', getreg('t'))
"     call setreg('b', getreg('n'))
"     call setreg('c', getreg('b'))
    
"     call setreg('t', ft)
"     call setreg('n', fn)
"     call setreg('b', bt)
" endfunction

" autocmd WinEnter * call TestLens()


nnoremap <silent><C-m> :call AutoResizeCurrentScreen()<CR>


