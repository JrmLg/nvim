function TelescopeFindFilesDynamicPath(withConfigPath=0)
    let search_dirs = []
    let cwd = getcwd()
    let cfp = expand('%:p:h')
    let con = stdpath('config')

    if stridx(cwd, cfp) == -1
        let cfp = expand('%:p:h:h')
    endif

    if stridx(cwd, con) == -1
        if a:withConfigPath
            call add(search_dirs, '"' . escape(con, '\') . '"')
            let bookmarks = con .. "/bookmarks/"
            call add(search_dirs, '"' . escape(bookmarks, '\') . '"')
        endif
    else
        let bookmarks = con .. "/bookmarks/"
        call add(search_dirs, '"' . escape(bookmarks, '\') . '"')
    endif

    if cfp != cwd
        if stridx(cwd, cfp) == -1
            if !a:withConfigPath || stridx(cwd, con) == -1 
                call add(search_dirs, '"' . escape(cwd, '\') . '"')
            endif
        endif
        
        if stridx(cfp, cwd) == -1
            if !a:withConfigPath || stridx(cfp, con) == -1
                call add(search_dirs, '"' . escape(cfp, '\') . '"')
            endif
        endif
    else
        call add(search_dirs, '"' . escape(cfp, '\') . '"')
    endif

    let dirs = join(search_dirs, ', ')
    execute "lua require('telescope.builtin').find_files({search_dirs = {" . dirs . "}})"
endfunction


nnoremap <BS>f <cmd>call TelescopeFindFilesDynamicPath()<CR>
nnoremap <BS>ff <cmd>call TelescopeFindFilesDynamicPath(1)<CR>
nnoremap <BS>b <cmd>Telescope buffers<CR>
nnoremap <BS>l <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <BS>c <cmd>Telescope commands<CR>
nnoremap <BS>' <cmd>Telescope marks<CR>
nnoremap <BS>" <cmd>Telescope registers<CR>
nnoremap <BS>m <cmd>Telescope keymaps<CR>
nnoremap <BS>o <cmd>Telescope oldfiles<CR>
nnoremap <BS>h <cmd>Telescope help_tags<CR>
nnoremap <BS>/ <cmd>Telescope search_history<CR>
nnoremap <BS>: <cmd>Telescope command_history<CR>
nnoremap <BS>s <cmd>Telescope treesitter<CR>

nnoremap <BS>g <cmd>Telescope git_files<CR>
nnoremap <BS>gc <cmd>Telescope git_commits<CR>
nnoremap <BS>gb <cmd>Telescope git_bcommits<CR>
nnoremap <BS>gs <cmd>Telescope git_status<CR>
nnoremap <BS>gt <cmd>Telescope git_stash<CR>
nnoremap <BS>gb <cmd>Telescope git_branches<CR>

nnoremap <BS>w <cmd>Telescope grep_string<CR>
nnoremap <BS>v <cmd>Telescope vim_options<CR>
