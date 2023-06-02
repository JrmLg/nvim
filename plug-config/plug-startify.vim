let g:startify_fortune_use_unicode = 1

let g:startify_session_dir = "~/AppData/Local/nvim/sessions"
let g:startify_session_before_save = ['call BeforeStartifySave()']

let g:startify_lists = [
        \ {'type': 'sessions',  'header': ['   Sessions']       },
        \ {'type': 'files',     'header': ['   Files']            },
        \ {'type': 'dir',       'header': ['   Directory : '. getcwd()] },
        \ {'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ ]

" \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
" \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
" \ { 'type': 'commands',  'header': ['   Commands']       },

let g:startify_bookmarks = []
call SourceIfExists('~/AppData/Local/nvim/bookmarks/bookmarks.vim')
let g:startify_bookmarks = extend(g:startify_bookmarks, [
      \ {'nvim': '~/AppData/Local/nvim'},
      \ {'vim': '~/AppData/Local/nvim'},
      \ {'app': '~/AppData'},
      \ {'coc': '~/AppData/Local/coc'},
      \ {'ala': '~/AppData/Roaming/alacritty'},
      \ ])

" https://patorjk.com/software/taag/#p=display&v=0&f=Ogre&t=NeoVim
let g:ascii = [
            \ "              __                _                    ",
            \ "           /\\ \\ \\___  ___/\\   /(_)_ __ ___           ",
            \ "          /  \\/ / _ \\/ _ \\ \\ / / | '_ ` _ \\          ",
            \ "         / /\\  /  __/ (_) \\ V /| | | | | | |         ",
            \ "         \\_\\ \\/ \\___|\\___/ \\_/ |_|_| |_| |_|         ",
            \]

let g:startify_custom_header = g:ascii + startify#fortune#boxed()

function CloseCocExplorer()
    let buffers = nvim_list_bufs()
    for b in buffers
        let is_loaded = nvim_buf_is_loaded(b)

        if is_loaded
            let b_filetype = getbufvar(b, '&filetype')
            if b_filetype == "coc-explorer"
                execute "bd!" . b
            endif
        endif
    endfor
endfunction

function BeforeStartifySave()
    execute "wa!"
    call CloseCocExplorer()
endfunction

" If startify open a directory, coc-explorer is open instead of netrw
augroup MyCocExplorer
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | silent! bd | exe 'CocCommand explorer ' . d | endif
augroup END
