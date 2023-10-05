local Rule = require('nvim-autopairs.rule')
local autopairs = require('nvim-autopairs')

autopairs.setup({
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = false,       -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    disable_in_replace_mode = true,
    ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
    enable_moveright = true,
    enable_afterquote = true,         -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
    enable_bracket_in_quote = true,   --
    enable_abbr = false,              -- trigger abbreviation
    break_undo = true,                -- switch for basic rule break undo sequence
    check_ts = false,
    map_cr = true,
    map_bs = true,   -- map the <BS> key
    map_c_h = false, -- Map the <C-h> key to delete a pair
    map_c_w = false, -- map <c-w> to delete a pair if possible
})


autopairs.add_rule(Rule("$$", "$$", "tex"))

-- you can use some built-in conditions

local cond = require('nvim-autopairs.conds')
-- print(vim.inspect(cond))

autopairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
        -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex("%%"))
        -- don't add a pair if  the previous character is xxx
            :with_pair(cond.not_before_regex("xxx", 3))
        -- don't move right when repeat character
            :with_move(cond.none())
        -- don't delete if the next character is xx
            :with_del(cond.not_after_regex("xx"))
        -- disable adding a newline when you press <cr>
            :with_cr(cond.none())
    },
    -- disable for .vim files, but it work for another filetypes
    Rule("a", "a", "-vim")
)

autopairs.add_rules({
    Rule("$$", "$$", "tex")
        :with_pair(function(opts)
            print(vim.inspect(opts))
            if opts.line == "aa $$" then
                -- don't add pair on that line
                return false
            end
        end)
}
)

-- you can use regex
-- press u1234 => u1234number
autopairs.add_rules({
    Rule("u%d%d%d%d$", "number", "lua")
        :use_regex(true)
})



-- press x1234 => x12341234
autopairs.add_rules({
    Rule("x%d%d%d%d$", "number", "lua")
        :use_regex(true)
        :replace_endpair(function(opts)
            -- print(vim.inspect(opts))
            return opts.prev_char:sub(#opts.prev_char - 3, #opts.prev_char)
        end)
})


-- you can do anything with regex +special key
-- example press tab to uppercase text:
-- press b1234s<tab> => B1234S1234S

-- autopairs.add_rules({
--   Rule("b%d%d%d%d%w$", "", "vim")
--     :use_regex(true,"<tab>")
--     :replace_endpair(function(opts)
--           return
--               opts.prev_char:sub(#opts.prev_char - 4,#opts.prev_char)
--               .."<esc>viwU"
--     end)
-- })

-- you can exclude filetypes
autopairs.add_rule(
    Rule("$$", "$$")
    :with_pair(cond.not_filetypes({ "lua" }))
)
--- check ./lua/nvim-autopairs/rules/basic.lua
