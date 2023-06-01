-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                -- See :h telescope.actions
                ["<C-k>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next",
                ["<ESC>"] = "close",
            }
        },

        layout_config = {
            prompt_position = 'top',

        },

        sorting_strategy = "ascending",

    },
    
    pickers = {
        command_history = {
            mappings = {
                i = {
                    ["<C-l>"] = "edit_command_line",
                }
            },
        },

        search_history = {
            mappings = {
                i = {
                    ["<C-l>"] = "edit_search_line",
                }
            }
        },
        
        registers = {
            mappings = {
                i = {
                    ["<C-l>"] = "edit_register",
                }
            }
        },

        -- find_files = {
        --     theme = "ivy",
        -- }
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    },
    
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
        }
    },
}



require('telescope').load_extension('fzf')
