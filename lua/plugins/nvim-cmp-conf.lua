return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",

		-- Snippets
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",

		"onsails/lspkind.nvim", -- Add icon in suggestion
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")
		local lspkind = require("lspkind")
		local snippetsDir = vim.fn.stdpath("config") .. "\\snippets"

		vim.api.nvim_set_hl(0, "GruvboxBlue", { fg = "#7aa2f7", bg = "#292E42" })
		vim.api.nvim_set_hl(0, "GruvboxOrange", { fg = "#FA8506", bg = "#292E42" })

		-- [[ Lua snippets ]]
		luasnip.config.setup({
			updateevents = "TextChanged,TextChangedI",
			delete_check_events = "TextChanged, InsertEnter",
			-- enable_autosnippets = true,

			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "●", "GruvboxOrange" } },
					},
				},
				[types.insertNode] = {
					active = {
						virt_text = { { "●", "GruvboxBlue" } },
					},
				},
			},
		})
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load() -- Import friendly snippets
		require("luasnip.loaders.from_lua").lazy_load({ paths = snippetsDir }) -- Import custom snippets

		vim.api.nvim_create_user_command("LuaSnipEditSnippets", function()
			local filetype = vim.bo.filetype
			local filePath = snippetsDir .. "\\" .. filetype .. ".lua"
			local fileExist = vim.fn.filereadable(filePath)

			if fileExist == 0 then
				vim.cmd("silent !touch " .. filePath)
				require("luasnip.loaders.from_lua").lazy_load({ paths = snippetsDir })
			end

			require("luasnip.loaders").edit_snippet_files({
				format = function(file, source_name)
					if source_name == "lua" then
						return "lua"
					end
					return nil
				end,
			})
		end, {
			desc = "Edit snippets of current.",
		})

		---@diagnostic disable-next-line: missing-fields
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<Down>"] = cmp.mapping.select_next_item(),
				["<Up>"] = cmp.mapping.select_prev_item(),
				-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
				-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),

				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<C-l>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<C-h>"] = cmp.mapping.abort(),
				["<C-j>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-i>"] = cmp.mapping(function(fallback)
					-- Change choice
					if luasnip.choice_active() then
						luasnip.change_choice(-1)
					end
				end, { "i", "s" }),

				["<C-o>"] = cmp.mapping(function(fallback)
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					end
				end, { "i", "s" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				-- Adjust comportement of nvim cmp when dealing with copilot
				["<M-h>"] = cmp.mapping(function(fallback)
					cmp.complete()
					fallback()
				end, { "i", "s" }),
				["<M-j>"] = cmp.mapping(function(fallback)
					cmp.close()
					fallback()
				end, { "i", "s" }),
				["<M-k>"] = cmp.mapping(function(fallback)
					cmp.close()
					fallback()
				end, { "i", "s" }),
			}),

			sources = {
				{ name = "luasnip" },
				-- { name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "path" },
			},

			---@diagnostic disable-next-line: missing-fields
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					max_width = 50,
					ellipsis_char = "...",
					symbol_map = { Copilot = "" },
				}),
			},

			-- sorting = {
			-- 	priority_weight = 2,
			-- 	comparators = {
			-- 		require("copilot_cmp.comparators").prioritize,
			--
			-- 		-- Below is the default comparitor list and order for nvim-cmp
			-- 		cmp.config.compare.offset,
			-- 		-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			-- 		cmp.config.compare.exact,
			-- 		cmp.config.compare.score,
			-- 		cmp.config.compare.recently_used,
			-- 		cmp.config.compare.locality,
			-- 		cmp.config.compare.kind,
			-- 		cmp.config.compare.sort_text,
			-- 		cmp.config.compare.length,
			-- 		cmp.config.compare.order,
			-- 	},
			-- },
		})
	end,
}
