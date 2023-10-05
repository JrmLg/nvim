require("tokyonight").setup({
    on_highlights = function(hl, c)
        hl.LspSignatureActiveParameter = {
            fg = "#FF55AF",
        }
    end
})

vim.cmd [[colorscheme tokyonight-storm]]
