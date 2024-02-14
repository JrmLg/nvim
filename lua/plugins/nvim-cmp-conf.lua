return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",

		-- Snippets
		"SirVer/ultisnips",
		"quangnguyen30192/cmp-nvim-ultisnips",
		"honza/vim-snippets",

		"onsails/lspkind.nvim", -- Add icon in suggestion
	},

	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		local cmpUltisnip = require("cmp_nvim_ultisnips")
		local cmpUltisnipMappings = require("cmp_nvim_ultisnips.mappings")

		vim.g.UltiSnipsSnippetDirectories = {
			vim.fn.stdpath("data") .. "/Lazy/vim-snippets/UltiSnips",
			vim.fn.stdpath("config") .. "/ultisnips",
		}

		cmpUltisnip.setup({})

		---@diagnostic disable-next-line: missing-fields
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["UltiSnips#Anon"](args.body)
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
				["<C-l>"] = cmp.mapping(function(fallback)
					if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
						vim.fn["UltiSnips#ExpandSnippet"]()
					else
						cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })(fallback)
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping.abort(),
				["<C-j>"] = cmp.mapping(function(fallback)
					cmpUltisnipMappings.jump_forwards(fallback)
				end, { "i", "s" }),
				["<C-k>"] = cmp.mapping(function(fallback)
					cmpUltisnipMappings.jump_backwards(fallback)
				end, { "i", "s" }),
				-- ["<C-i>"] = cmp.mapping(function(fallback)
				-- 	-- Change choice
				-- 	if luasnip.choice_active() then
				-- 		luasnip.change_choice(-1)
				-- 	end
				-- end, { "i", "s" }),
				--
				-- ["<C-o>"] = cmp.mapping(function(fallback)
				-- 	if luasnip.choice_active() then
				-- 		luasnip.change_choice(1)
				-- 	end
				-- end, { "i", "s" }),
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
				{ name = "ultisnips" },
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
