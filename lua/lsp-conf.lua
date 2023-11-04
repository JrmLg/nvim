require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { 'lua_ls', 'tsserver', 'vimls', 'jsonls', 'html', 'cssls', 'pylsp' },
    automatic_installation = true,
})


local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', '<BS>r', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', '<C-CR>', vim.lsp.buf.hover, {})
    vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, {})

    require('lsp_signature').on_attach({
        bind = true,
        hint_enable = true,
        -- hint_prefix = '(Ctrl+Enter) ',
        hint_prefix = '',
        always_triger = false,
        toggle_key = '<C-CR>',
        hi_parameter = 'LspSignatureActiveParameter',
        handler_opts = {
            border = 'none',
            -- border = 'rounded',
        },

        floating_window = false,

        doc_lines = 15,
        max_height = 15,
        max_width = 80,
        -- verbose = false,
    }, bufnr)

    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})


require("lspconfig").tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        javascript = {
            autoClosingTags = true,
        },

        typescript = {
            autoClosingTags = true,
        },

        codeActionsOnSave = {
            source = {
                organizeImports = true,
            }
        }
    }
})

require("lspconfig").vimls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        isNeovim = true,
    }
})

require("lspconfig").eslint_d.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        html = {
            format = {
                wrapLineLength = 100,
            }
        }

    }
})

require("lspconfig").cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig").pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
