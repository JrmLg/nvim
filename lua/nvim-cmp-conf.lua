local cmp = require('cmp')
local types = require('cmp.types')

require('cmp_nvim_ultisnips').setup({})


-- Snippets setup
vim.g.UltiSnipsSnippetDirectories = {
    vim.fn.stdpath('config') .. '/autoload/plugged/vim-snippets/UltiSnips',
    vim.fn.stdpath('config') .. '/ultisnips'
}


cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
        end,
    },

    mapping = {
        ['<C-h>'] = cmp.mapping.abort(),
        ['<Down>'] = { i = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }), },
        ['<Up>'] = { i = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }), },
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),

        ['<TAB>'] = cmp.mapping.select_next_item(),
        ['<S-TAB>'] = cmp.mapping.select_prev_item(),


        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-l>'] = cmp.mapping(
            function(fallback)
                require('cmp_nvim_ultisnips.mappings').expand_or_jump_forwards(fallback)
            end,
            { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }
        ),
        ['<C-k>'] = cmp.mapping(
            function(fallback)
                require('cmp_nvim_ultisnips.mappings').jump_backwards(fallback)
            end,
            { 'i', 's', --[[ 'c' (to enable the mapping in command mode) ]] }
        ),
    },
    sources = {
        { name = 'copilot',   group_index = 2 },
        { name = 'nvim_lsp',  group_index = 1 },
        { name = 'path',      group_index = 2 },
        { name = 'ultisnips', group_index = 2 }, -- For ultisnips users.
    }
    -- sources = cmp.config.sources({
    --     { name = 'nvim_lsp',  group_index = 1 },
    --     { name = 'path',      group_index = 2 },
    --     { name = 'ultisnips', gorup_index = 2 }, -- For ultisnips users.
    --     { name = 'copilot',   group_index = 2 },
    --     -- { name = 'vsnip' }, -- For vsnip users.
    --     -- { name = 'luasnip' },   -- For luasnip users.
    --     -- { name = 'snippy' }, -- For snippy users.
    -- }, {
    --     { name = 'buffer' },
    -- })
})


-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--   }, {
--     { name = 'buffer' },
--   })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
