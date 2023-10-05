call plug#begin('~/AppData/Local/nvim/autoload/plugged')

" ------------------------- Themes and visual aspect -------------------------
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'folke/tokyonight.nvim'
    Plug 'ap/vim-css-color'
    Plug 'equalsraf/neovim-gui-shim'

" ---------------------------- Help and utilities ----------------------------
    Plug 'uga-rosa/translate.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'MunifTanjim/nui.nvim'
    Plug 'neoclide/vim-jsx-improve'

" ----------------------------- Code completion ------------------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'hrsh7th/cmp-path'
    Plug 'zbirenbaum/copilot.lua'

" --------------------------------- Linters and formater ----------------------------------
    Plug 'dense-analysis/ale'

" ---------------------------- Navigation helpers ----------------------------
    Plug 'nvim-neo-tree/neo-tree.nvim'
    Plug 's1n7ax/nvim-window-picker'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'mhinz/vim-startify'
    Plug 'easymotion/vim-easymotion'
    Plug 'justinmk/vim-sneak'
    Plug 'romainl/vim-cool'
    Plug 'camspiers/animate.vim'
    Plug 'camspiers/lens.vim'
    Plug 'inkarkat/vim-CursorLineCurrentWindow'
    Plug 'joeytwiddle/sexy_scroller.vim'

" ----------------------------- Code versionning -----------------------------
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

" --------------------------- Code edition helpers ---------------------------
    Plug 'windwp/nvim-autopairs'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'vim-scripts/ReplaceWithRegister'
    Plug 'vim-scripts/loremipsum'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" ---------------------------- Debug code helpers ----------------------------
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'mxsdev/nvim-dap-vscode-js'
    Plug 'microsoft/vscode-js-debug'

call plug#end()
