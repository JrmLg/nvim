return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"ray-x/lsp_signature.nvim",

		-- Useful status updates for LSP
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			opts = {},
		},

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
	},

	config = function()
		-- Setup neovim lua configuration
		require("neodev").setup()

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true -- Enable emmet_ls snippet support

		-- If you want to override the default filetypes that your language server will attach to you can
		-- define the property 'filetypes' to the map in question.
		local servers = {

			lua_ls = {
				filetypes = { "lua" },

				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},

			tsserver = {
				-- filetypes = { "javascript", "typescript", "javascriptreact" },

				javascript = {
					autoClosingTags = true,
				},

				typescript = {
					autoClosingTags = true,
				},

				codeActionsOnSave = {
					source = {
						organizeImports = true,
					},
				},
			},

			sqlls = {
				filetypes = { "sql" },
			},

			vimls = {
				filetypes = { "vim" },

				isNeovim = true,
			},

			eslint = {
				filetypes = { "javascript", "typescript" },
			},

			jsonls = {
				filetypes = { "json" },
			},

			cssls = {
				filetypes = { "css" },
			},

			emmet_ls = {
				filetypes = {
					"css",
					"eruby",
					"html",
					-- "javascript",
					-- "typescript",
					-- "javascriptreact",
					-- "typescriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"pug",
					"vue",
				},
			},

			html = {
				filetypes = { "html", "twig", "hbs" },
				html = {
					format = {
						wrapLineLength = 100,
						indentInnerHtml = false,
					},
				},
			},

			pyright = {
				filetypes = { "python" },
			},

			rust_analyzer = {
				filetypes = { "rust" },
			},
		}

		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")

		-- Ensure the servers above are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = require("lsp-mapping").on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})
	end,
}
