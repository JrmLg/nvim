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
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		-- Additional lua configuration, makes nvim stuff amazing!
		"folke/neodev.nvim",
	},

	config = function()
		local builtin = require("telescope.builtin")

		local on_attach = function(client, bufnr)
			vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame." })
			vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction." })
			vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr, desc = "[G]o to [D]efinition." })
			vim.keymap.set("n", "ge", builtin.lsp_references, { buffer = bufnr, desc = "[G]o to r[E]ferences." })
			vim.keymap.set(
				"n",
				"gi",
				builtin.lsp_implementations,
				{ buffer = bufnr, desc = "[G]o to [I]mplementation." }
			)
			vim.keymap.set("n", "<BS>D", builtin.lsp_definitions, { buffer = bufnr, desc = "Type [D]efinition." })
			vim.keymap.set(
				"n",
				"<BS>ds",
				builtin.lsp_document_symbols,
				{ buffer = bufnr, desc = "[D]ocument [S]ymbols." }
			)
			vim.keymap.set(
				"n",
				"<BS>ws",
				builtin.lsp_dynamic_workspace_symbols,
				{ buffer = bufnr, desc = "[W]orkspace [S]ymbols" }
			)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "[K] Hover Documentation." })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<C-k>",
			-- 	vim.lsp.buf.signature_help,
			-- 	{ buffer = bufnr, desc = "Signature documentation." }
			-- )
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]o to [D]ecaration." })
			vim.keymap.set(
				"n",
				"<leader>wa",
				vim.lsp.buf.add_workspace_folder,
				{ buffer = bufnr, desc = "[W]orkspace [A]dd Folder" }
			)
			vim.keymap.set(
				"n",
				"<leader>wr",
				vim.lsp.buf.remove_workspace_folder,
				{ buffer = bufnr, desc = "[W]orkspace [R]emove Folder" }
			)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { buffer = bufnr, desc = "[W]orkspace [L]ist Folders" })

			require("lsp_signature").on_attach({
				bind = true,
				hint_enable = true,
				-- hint_prefix = '(Ctrl+Enter) ',
				hint_prefix = "",
				always_triger = false,
				toggle_key = "<C-CR>",
				hi_parameter = "LspSignatureActiveParameter",
				handler_opts = {
					border = "none",
					-- border = 'rounded',
				},

				floating_window = false,
				doc_lines = 15,
				max_height = 15,
				max_width = 100,
				-- verbose = false,
			}, bufnr)

			-- if client.supports_method("textDocument/formatting") then
			-- 	vim.api.nvim_create_augroup('Format', {})
			-- 	vim.api.nvim_clear_autocmds({ group = "Format", buffer = bufnr })
			-- 	vim.api.nvim_create_autocmd("BufWritePre", {
			-- 		group = "Format",
			-- 		buffer = bufnr,
			-- 		callback = function()
			-- 			vim.lsp.buf.format()
			-- 		end,
			-- 	})
			-- else
			-- 	print("No formatter available for " .. client.name)
			-- end
		end

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
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"pug",
					"typescriptreact",
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
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				})
			end,
		})
	end,
}
