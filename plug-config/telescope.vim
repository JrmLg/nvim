function TelescopeFindFilesDynamicPath(withConfigPath=0)
    let search_dirs = []
    let cwd = getcwd()
    let cfp = expand('%:p:h')
    let con = stdpath('config')

    if stridx(cwd, cfp) == -1
        let cfp = expand('%:p:h:h')
    endif

    if a:withConfigPath && stridx(cwd, con) == -1
        call add(search_dirs, '"' . escape(con, '\') . '"')
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


nnoremap !f <cmd>call TelescopeFindFilesDynamicPath()<CR>
nnoremap !ff <cmd>call TelescopeFindFilesDynamicPath(1)<CR>
nnoremap !b <cmd>Telescope buffers<CR>
nnoremap !l <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap !c <cmd>Telescope commands<CR>
nnoremap !' <cmd>Telescope marks<CR>
nnoremap !" <cmd>Telescope registers<CR>
nnoremap !m <cmd>Telescope keymaps<CR>
nnoremap !o <cmd>Telescope oldfiles<CR>
nnoremap !h <cmd>Telescope help_tags<CR>
nnoremap !/ <cmd>Telescope search_history<CR>
nnoremap !: <cmd>Telescope command_history<CR>

nnoremap !g <cmd>Telescope git_files<CR>
nnoremap !gc <cmd>Telescope git_commits<CR>
nnoremap !gb <cmd>Telescope git_bcommits<CR>
nnoremap !gs <cmd>Telescope git_status<CR>
nnoremap !gt <cmd>Telescope git_stash<CR>
nnoremap !gb <cmd>Telescope git_branches<CR>

nnoremap !w <cmd>Telescope grep_string<CR>
nnoremap !v <cmd>Telescope vim_options<CR>
