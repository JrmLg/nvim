return {
	"mhartington/formatter.nvim",

	dependencies = {
		"williamboman/mason.nvim",
	},

	config = function()
		local registry = require("mason-registry")

		local function ensure_installed(formatters)
			for _, formatter in ipairs(formatters) do
				if registry.has_package(formatter) then
					if not registry.is_installed(formatter) then
						vim.cmd("MasonInstall " .. formatter)
					end
				end
			end
		end

		vim.api.nvim_create_augroup("Format", {})
		vim.api.nvim_clear_autocmds({ group = "Format" })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = "Format",
			command = "FormatWrite",
		})

		local util = require("formatter.util")

		local function prettierd()
			return {
				exe = "prettierd",
				args = {
					"--config-precedence=file-override",
					"--tab-width=2",
					"--print-width=140",
					"--single-quote=true",
					"--semi=false",
					"--check",
					util.escape_path(util.get_current_buffer_file_path()),
				},
				stdin = true,
			}
		end

		local function sqlfluff()
			return {
				exe = "sqlfluff",
				args = {
					"format",
					"--disable-progress-bar",
					"--nocolor",
					"--dialect=postgres",
					"-",
				},
				stdin = true,
				ignore_exitcode = true,
			}
		end

		local function stylua()
			return {
				exe = "stylua",
				args = {
					"--search-parent-directories",
					"--stdin-filepath",
					util.escape_path(util.get_current_buffer_file_path()),
					"--",
					"-",
				},
				stdin = true,
			}
		end

		ensure_installed({
			"stylua", -- for lua file
			"prettierd", -- for js, ts, css, html, json, md
			"black", -- for python
			"sqlfluff", -- for sql,
		})

		require("formatter").setup({
			logging = true, -- Enable or disable logging
			log_level = vim.log.levels.WARN, -- Set the log level

			-- All formatter configurations are opt-in
			filetype = {
				css = { prettierd },
				html = { prettierd },
				javascript = { prettierd },
				javascriptreact = { prettierd },
				json = { prettierd },
				markdown = { prettierd },
				python = { require("formatter.filetypes.python").black },
				lua = { stylua },
				typescript = { prettierd },
				typescriptreact = { prettierd },
				sql = { sqlfluff },

				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any
					-- filetype
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
	end,
}
