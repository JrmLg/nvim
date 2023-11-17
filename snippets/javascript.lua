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

return {
	s(
		{
			trig = "log",
			desc = "Log into the console.",
			priority = 1000,
		},
		fmt("console.log({})", {
			i(0),
		})
	),

	s({
		trig = "json",
		desc = "Transform an object to JSON.",
		priority = 1000,
	}, {
		c(1, {
			sn(nil, fmt("JSON.stringify({})", { r(1, "object") })),
			sn(nil, fmt("let {}Json = JSON.stringify({})", { rep(1), r(1, "object") })),
			sn(nil, fmt("JSON.{}", { r(1, "object") })),
		}),
		i(0),
	}, {
		stored = {
			["object"] = i(1, "object"),
		},
	}),

	s(
		{
			trig = "l",
			desc = "Insert a lambda function.",
			priority = 1000,
		},
		fmt("({1}) => {{{2}}}", {
			i(1),
			i(2),
		})
	),

	s(
		{
			trig = "f",
			desc = "Insert a function.",
			priority = 1000,
		},
		fmt("function {1}({2}) {{{3}}}", {
			i(1, "name"),
			i(2),
			i(3),
		})
	),

	s(
		{
			trig = "df",
			desc = "Insert a function.",
			priority = 1000,
		},
		fmt("export default function {1}({2}) {{{3}}}", {
			i(1, "name"),
			i(2),
			i(3),
		})
	),

	s(
		{
			trig = "cl",
			desc = "Insert a class.",
			priority = 1000,
		},
		fmt(
			[[
				class {1} {2} {{

					{3}

				}}
			]],
			{
				i(1, "ClassName"),
				sn(2, {
					n(1, "extends "),
					i(1, ""),
				}),
				i(0),
			}
		)
	),

	s(
		{
			trig = "constructor",
			desc = "Insert a constructor.",
			priority = 1000,
		},
		fmt(
			[[
				constructor({}) {{
					{}
				}}
			]],
			{
				i(1),
				i(2),
			}
		)
	),
}
