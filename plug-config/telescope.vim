function NormalizePath(path)
    let path = substitute(a:path, '/', '\', 'g')
    return escape(path, '\')
endfunction

function FirstPathContainsSecond(first, second)
    if stridx(a:second, a:first) != -1
        return 1 
    else 
        return 0
    endif
endfunction

function MergePaths(paths, newPath)
    let paths = a:paths
    let newPath = NormalizePath(a:newPath)
    let mergedPaths = []
    let mustBeMerged = 1

    if len(paths) == 0
        return [newPath]
    endif

    for path in paths
        let newPathContainPath = FirstPathContainsSecond(newPath, path)
        let pathContainNewPath = FirstPathContainsSecond(path, newPath)

        if path == newPath || pathContainNewPath == 1
            return paths
        endif

        if newPathContainPath == 0
            call add(mergedPaths, path)
        endif

        if pathContainNewPath == 1
            let mustBeMerged = 0
        endif
    endfor

    if mustBeMerged == 1
        call add(mergedPaths, newPath)
    endif

    return mergedPaths
endfunction

function GetDynamicPath(withConfigPath=0)
    let search_dirs = []
    let workingDir = getcwd()
    let currentFilePath = expand('%:p:h')
    let configPath = stdpath('config')

    if stridx(workingDir, currentFilePath) == -1
        let currentFilePath = expand('%:p:h:h')
    endif

    if stridx(workingDir, configPath) == -1
        if a:withConfigPath
            let search_dirs = MergePaths(search_dirs, configPath)
        endif
    endif

    if currentFilePath != workingDir
        if stridx(workingDir, currentFilePath) == -1
            if !a:withConfigPath || stridx(workingDir, configPath) == -1 
                let search_dirs = MergePaths(search_dirs, workingDir)
            endif
        endif
        
        if stridx(currentFilePath, workingDir) == -1
            if !a:withConfigPath || stridx(currentFilePath, configPath) == -1
                let search_dirs = MergePaths(search_dirs, currentFilePath)
            endif
        endif
    else
        let search_dirs = MergePaths(search_dirs, currentFilePath)
   endif

    call map(search_dirs, {pos, val -> '"' . val . '"'})
    return join(search_dirs, ', ')
endfunction

function TelescopeFindFilesDynamicPath(withConfigPath=0)
    execute "lua require('telescope.builtin').find_files({search_dirs = {" . GetDynamicPath(a:withConfigPath) . "}})"
endfunction

function TelescopeLiveGrepConfigPath()
    let configPath = '"' . NormalizePath(stdpath('config')) . '"'
    execute "lua require('telescope.builtin').live_grep({search_dirs = {" . configPath . "}})"
endfunction

nnoremap <BS>f <cmd>call TelescopeFindFilesDynamicPath()<CR>
nnoremap <BS>ff <cmd>call TelescopeFindFilesDynamicPath(1)<CR>
nnoremap <BS>b <cmd>Telescope buffers<CR>
nnoremap <BS>l <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <BS>ll <cmd>Telescope live_grep<CR>
nnoremap <BS>lc <cmd>call TelescopeLiveGrepConfigPath()<CR>
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
