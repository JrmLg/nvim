-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important

local actions = require("telescope.actions")

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local selected_entry = action_state.get_selected_entry()
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end

function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "split")
end

function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

-- local transform_mod = require('telescope.actions.mt').transform_mod

-- -- or create your custom action
-- local my_cool_custom_action = transform_mod({
--   x = function()
--     print("This function ran after another action. Prompt_bufnr: " )
--     -- Enter your function logic here. You can take inspiration from lua/telescope/actions.lua
--   end,
-- })

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            -- "node_modules",
        },


        mappings = {
            i = {
                -- See :h telescope.actions
                ["<C-k>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next",
                ["<C-i>"] = "file_vsplit",
                ["<ESC>"] = "close",
                ["<C-BS>"] = { "<C-u>", type = "command" },
                ["<C-c>"] = actions.delete_buffer + actions.move_to_top,
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
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
}



require('telescope').load_extension('fzf')
