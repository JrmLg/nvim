require('nvim-treesitter.configs').setup({
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['as'] = '@scope',
                ['ab'] = '@block.outer',
                ['ib'] = '@block.inner',
                ['ag'] = '@comment.outer',
                ['ig'] = '@comment.inner',
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@function.outer'] = 'V',
                ['@function.inner'] = 'v',
                ['@class.outer'] = '<c-v>',
                ['@class.inner'] = 'v',
                ['@scope'] = 'v',
                ['@block.outer'] = 'V',
                ['@block.inner'] = 'v',
                ['@comment.outer'] = 'V',
                ['@comment.inner'] = 'v',
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- and should return true of false
            include_surrounding_whitespace = true,
        },
    },
})
