local function on_attach(client, bufnr)
	local builtin = require("telescope.builtin")
	-- fix bug on format with gq shortcut
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")

	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame." })
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction." })
	vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = bufnr, desc = "[G]o to [D]efinition." })
	vim.keymap.set("n", "ge", builtin.lsp_references, { buffer = bufnr, desc = "[G]o to r[E]ferences." })
	vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = bufnr, desc = "[G]o to [I]mplementation." })
	vim.keymap.set("n", "<BS>D", builtin.lsp_definitions, { buffer = bufnr, desc = "Type [D]efinition." })
	vim.keymap.set("n", "<BS>ds", builtin.lsp_document_symbols, { buffer = bufnr, desc = "[D]ocument [S]ymbols." })
	vim.keymap.set(
		"n",
		"<BS>ss",
		builtin.lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = "Workspace [S]ymbol[S]" }
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
end

return {
	on_attach = on_attach,
}
