function OpenCocExplorerWithoutAnimation(path="") abort
    let g:lens#animate=0
    if a:path != ""
        execute "CocCommand explorer " . a:path
    else
        execute "CocCommand explorer"
    endif
    sleep 10m
    let g:lens#animate=1
endfunction
