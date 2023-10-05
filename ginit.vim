
" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    execute "GuiFont! Hack Nerd Font:h11"
    " execute "GuiFont! Cascadia Code:h11"
endif

if exists(':GuiTabline')
    GuiTabline 0
endif

if exists(':GuiWindowOpacity')
    GuiWindowOpacity 1
endif

let s:windowFullScreen = 0

function WindowMaximizedToogle()
    let save_pos = getpos(".")
    if s:windowFullScreen
        execute GuiWindowMaximized(0)
        let s:windowFullScreen = 0
    else
        execute GuiWindowMaximized(1)
        let s:windowFullScreen = 1
    endif
    call setpos('.', save_pos)

endfunction

" noremap <M-Enter> :call WindowMaximizedToogle()<CR>
