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
				settings = {
					filetypes = { "lua" },

					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			},

			tsserver = {
				-- filetypes = { "javascript", "typescript", "javascriptreact" },
				on_attach = function(client, bufnr)
					local function organizeImports()
						local params = {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
							title = "",
						}
						vim.lsp.buf.execute_command(params)
					end

					vim.keymap.set("n", "go", organizeImports, { buffer = bufnr, desc = "[G]et organized [I]mports." })

					print("tsserver attached")
				end,

				settings = {
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
			},

			sqlls = {
				settings = { filetypes = { "sql" } },
			},

			vimls = {
				settings = {
					filetypes = { "vim" },
					isNeovim = true,
				},
			},

			eslint = {
				settings = { filetypes = { "javascript", "typescript" } },
			},

			jsonls = {
				settings = { filetypes = { "json" } },
			},

			cssls = {
				settings = { filetypes = { "css" } },
			},

			emmet_ls = {
				settings = {
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
			},

			html = {
				settings = {
					filetypes = { "html", "twig", "hbs" },
					html = {
						format = {
							wrapLineLength = 100,
							indentInnerHtml = false,
						},
					},
				},
			},

			pyright = {
				settings = { filetypes = { "python" } },
			},

			rust_analyzer = {
				settings = { filetypes = { "rust" } },
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
					on_attach = function(client, bufnr)
						require("lsp-mapping").on_attach(client, bufnr)

						if servers[server_name].on_attach then
							servers[server_name].on_attach(client, bufnr)
						end
					end,
					settings = servers[server_name].settings or {},
					filetypes = (servers[server_name].settings or {}).filetypes,
				})
			end,
		})
	end,
}
