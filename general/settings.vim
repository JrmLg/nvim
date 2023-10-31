" set leader key
let g:mapleader = "\<Space>"
let g:netrw_fastbrowse = 0              " Close VimExplorer after selecting file

colorscheme tokyonight-storm
syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                               " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set laststatus=0                        " Always display the status line
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set textwidth=80
set autoindent                          " Good auto indent
set formatoptions=cnrqjl                " Stop newline continution of comments
set scrolloff=6                         " Minimal number of screen lines to keep above and below the cursor.
set incsearch                           " While typing a search command, show where the pattern, as it was typed so far, matches.
set foldmethod=indent                   " more indent means a higher fold level
set foldlevel=9
set listchars=tab:=>,eol:$
set virtualedit=onemore                 " Allow the cursor to move just past the end of the line
set selection=inclusive
set signcolumn=yes
set autoread
set listchars+=space:.
" set matchpairs=(:),{:},[:]


autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
autocmd Filetype * setlocal formatoptions=cnrqjl " Overwrite ftplugin for formatoptions
autocmd BufEnter,Filetype git setlocal foldmethod=syntax | setlocal foldlevel=1 " Enable folding for git commits

" trigger `autoread` when files changes on disk
" and notification after file change
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if !bufexists("[Command Line]") && mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Set template view ejs files as normal html file for autocompletion
autocmd BufNewFile,BufRead *.ejs set filetype=html

" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
