require('lualine').setup({
    options = {
        icons_enable = true,
        theme = 'tokyonight',
        disabled_filetypes = {
            "neo-tree",
            "startify",
            "help",
            "qf",
        },
        disabled_winbar = {
            "neo-tree",
            "startify",
            "help",
            "qf",
        },
        disabled_buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
            "help",
        },
    },
})
