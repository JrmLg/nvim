call plug#begin('~/AppData/Local/nvim/autoload/plugged')

" ------------------------- Themes and visual aspect -------------------------
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ap/vim-css-color'
    Plug 'equalsraf/neovim-gui-shim'

" -------------------------- Help with translation ---------------------------
    Plug 'voldikss/vim-translator'
    
" ----------------------------- Code completion ------------------------------
    Plug 'windwp/nvim-autopairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" ---------------------------- Navigation helpers ----------------------------
    Plug 'mhinz/vim-startify'
    Plug 'easymotion/vim-easymotion'
    Plug 'romainl/vim-cool'
    Plug 'max397574/better-escape.nvim'
    Plug 'camspiers/animate.vim'
    Plug 'camspiers/lens.vim'
    Plug 'inkarkat/vim-CursorLineCurrentWindow'
    Plug 'joeytwiddle/sexy_scroller.vim'
    
" ----------------------------- Code versionning -----------------------------
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

" --------------------------- Code edition helpers ---------------------------
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim' 
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'vim-scripts/loremipsum'

" ---------------------------- Debug code helpers ----------------------------
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'mfussenegger/nvim-dap-python'

call plug#end()
