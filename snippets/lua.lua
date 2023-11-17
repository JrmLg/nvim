local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function newSnippets()
	return sn(
		nil,
		fmt(
			[=[
				s({{
					trig = "{1}",
					desc = "{2}",
					priority = 1000,
				}}, fmt({3},{{
					{4}
				}})),
			]=],
			{
				i(1, "trigger"),
				i(2, "Snippet description."),
				c(3, {
					sn(nil, { t({ "[[", "" }), r(1, "snippet"), t({ "", "]]" }) }),
					sn(nil, { t('"'), r(1, "snippet"), t('"') }),
				}),
				i(4),
			}
		),
		{
			stored = {
				["snippet"] = i(1, "snippet"),
			},
		}
	)
end

return {

	s({
		trig = "snippet",
		desc = "Insert a new snippet.",
		priority = 1000,
	}, {
		d(1, newSnippets),
	}),

	s(
		{
			trig = "luasnipModules",
			desc = "Import all modules for luasnip snippets.",
			priority = 1000,
		},
		fmt(
			[[
				local ls = require("luasnip")
				local s = ls.snippet
				local sn = ls.snippet_node
				local isn = ls.indent_snippet_node
				local t = ls.text_node
				local i = ls.insert_node
				local f = ls.function_node
				local c = ls.choice_node
				local d = ls.dynamic_node
				local r = ls.restore_node
				local events = require("luasnip.util.events")
				local ai = require("luasnip.nodes.absolute_indexer")
				local extras = require("luasnip.extras")
				local l = extras.lambda
				local rep = extras.rep
				local p = extras.partial
				local m = extras.match
				local n = extras.nonempty
				local dl = extras.dynamic_lambda
				local fmt = require("luasnip.extras.fmt").fmt
				local fmta = require("luasnip.extras.fmt").fmta
				local conds = require("luasnip.extras.expand_conditions")
				local postfix = require("luasnip.extras.postfix").postfix
				local types = require("luasnip.util.types")
				local parse = require("luasnip.util.parser").parse_snippet
				local ms = ls.multi_snippet
				local k = require("luasnip.nodes.key_indexer").new_key

				return {{
					{}
				}}
			]],
			{
				d(1, newSnippets),
			}
		)
	),

	s(
		{
			trig = "req",
			priority = 1500,
		},
		fmt([[local {} = require("{}")]], {
			f(function(import_name)
				local parts = vim.split(import_name[1][1], ".", { plain = true })
				print(vim.inspect(parts))
				return parts[#parts] or import_name[1][1]
			end, { 1 }),
			i(1),
		})
	),

	s(
		{
			trig = "keymap",
			desc = "Insert a new vim keymap.",
			priority = 1000,
		},
		fmt(
			[[
			vim.keymap.set("{1}", "{2}", {3}, {{
				silent = true,
				noremap = true,
				desc = "{4}",
			}})
			]],
			{
				i(1, "n"),
				i(2, "<Shortcut>"),
				i(3, '":Command<CR>"'),
				i(4, "Description."),
			}
		)
	),

}

