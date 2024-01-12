return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},

	config = function()
		local actions = require("telescope.actions")

		-- local telescope_custom_actions = {}
		--
		-- function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
		-- 	local picker = actions.state.get_current_picker(prompt_bufnr)
		-- 	local num_selections = #picker:get_multi_selection()
		-- 	if not num_selections or num_selections <= 1 then
		-- 		actions.add_selection(prompt_bufnr)
		-- 	end
		-- 	actions.send_selected_to_qflist(prompt_bufnr)
		-- 	vim.cmd("cfdo " .. open_cmd)
		-- end
		--
		-- function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
		-- 	telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
		-- end
		--
		-- function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
		-- 	telescope_custom_actions._multiopen(prompt_bufnr, "split")
		-- end
		--
		-- function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
		-- 	telescope_custom_actions._multiopen(prompt_bufnr, "tabe")
		-- end
		--
		-- function telescope_custom_actions.multi_selection_open(prompt_bufnr)
		-- 	telescope_custom_actions._multiopen(prompt_bufnr, "edit")
		-- end

		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					-- "node_modules",
				},

				mappings = {
					i = {
						-- See :h telescope.actions
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
						["<C-i>"] = "file_vsplit",
						["<C-h>"] = "file_split",
						["<ESC>"] = "close",
						["<C-BS>"] = { "<C-u>", type = "command" },
						["<C-c>"] = actions.delete_buffer + actions.move_to_top,
					},
				},

				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},

			pickers = {
				command_history = {
					mappings = {
						i = {
							["<C-l>"] = "edit_command_line",
						},
					},
				},

				search_history = {
					mappings = {
						i = {
							["<C-l>"] = "edit_search_line",
						},
					},
				},

				registers = {
					mappings = {
						i = {
							["<C-l>"] = "edit_register",
						},
					},
				},
			},

			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		})
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")

		-- vim.keymap.set('n', '<BS>l', function()
		-- 	-- You can pass additional configuration to telescope to change theme, layout, etc.
		-- 	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		-- 		winblend = 5,
		-- 		previewer = false,
		-- 	})
		-- end, { desc = '[/] Fuzzily search in current buffer' })
		vim.keymap.set("n", "<BS>f", builtin.find_files, { desc = "Search [F]iles" })
		vim.keymap.set("n", "<BS>ff", function()
			require("myFunctions").telescopeFindFilesDynamicPath(1)
		end, { desc = "Search [F]iles including config files." })
		vim.keymap.set("n", "<BS><TAB>", builtin.buffers, { desc = "[TAB] Find existing buffers." })
		vim.keymap.set("n", "<BS>l", builtin.current_buffer_fuzzy_find, { desc = "Search a [L]ine in current buffer." })
		vim.keymap.set("n", "<BS>ll", function()
			builtin.grep_string({ shorten_path = true, word_path = "-w", only_sort_text = true, search = "" })
		end, { desc = "Search a [L][L]ine in current folder." })
		vim.keymap.set("n", "<BS>lc", function()
			require("myFunctions").telescopeLiveGrepConfigPath()
		end, { desc = "Search a [L][L]ine in current folder." })
		vim.keymap.set("n", "<BS>c", builtin.commands, { desc = "Find a [C]ommand." })
		vim.keymap.set("n", "<BS>'", builtin.marks, { desc = "['] Find a mark." })
		vim.keymap.set("n", '<BS>"', builtin.registers, { desc = '["] Find a register.' })
		vim.keymap.set("n", "<BS>m", builtin.keymaps, { desc = "Find a [M]apping." })
		vim.keymap.set("n", "<BS>o", builtin.oldfiles, { desc = "[?] Find recently opened files." })
		vim.keymap.set("n", "<BS>h", builtin.help_tags, { desc = "Search [H]elp." })
		vim.keymap.set("n", "<BS>/", builtin.search_history, { desc = "[/] Search search in history." })
		vim.keymap.set("n", "<BS>:", builtin.command_history, { desc = "[:] Search command in history." })
		vim.keymap.set("n", "<BS>s", builtin.treesitter, { desc = "Search [S]ymbol with treesitter." })

		vim.keymap.set("n", "<BS>gc", builtin.git_bcommits, { desc = "Search [G]it [C]ommit of current buffer." })
		vim.keymap.set("n", "<BS>gcc", builtin.git_commits, { desc = "Search [G]it [C]ommit." })
		vim.keymap.set("n", "<BS>gs", builtin.git_status, { desc = "Search [G]it [S]atus." })
		vim.keymap.set("n", "<BS>gt", builtin.git_stash, { desc = "Search [G]it s[T]ash." })
		vim.keymap.set("n", "<BS>gb", builtin.git_branches, { desc = "Search [G]it [B]ranch." })

		vim.keymap.set("n", "<BS>w", builtin.grep_string, { desc = "Search current [W]ord." })
		vim.keymap.set("n", "<BS>d", builtin.diagnostics, { desc = "Search [D]iagnostics." })
		vim.keymap.set("n", "<BS>r", builtin.resume, { desc = "Search [R]eference." })
		vim.keymap.set("n", "<BS>v", builtin.vim_options, { desc = "Search [v]im options." })
	end,
}
