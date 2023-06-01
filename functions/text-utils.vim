
function ListToggle()
    if (&list == 0)
        execute "set list"
    else
        execute "set nolist"
    endif
endfunction

nnoremap <silent>§ :call ListToggle()<CR>


