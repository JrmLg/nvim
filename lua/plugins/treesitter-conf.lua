return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter.configs").setup({
			-- Add languages to be installed here that you want installed for treesitter
			ignore_install = {},
			modules = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"python",
				"query",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua",
				"python",
				"query",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = true,

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				-- disable = { "c", "rust" },
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			indent = {
				disable = { "html" },
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<M-space>",
				},
			},

			autotag = {
				enable = true,
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- ["aa"] = "@parameter.outer",
						-- ["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["as"] = "@scope",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["ag"] = "@comment.outer",
						["ig"] = "@comment.inner",
					},

					selection_modes = {
						["@function.outer"] = "V",
						["@function.inner"] = "v",
						["@class.outer"] = "V",
						["@class.inner"] = "v",
						["@scope"] = "v",
						["@block.outer"] = "V",
						["@block.inner"] = "v",
						["@comment.outer"] = "V",
						["@comment.inner"] = "v",
					},

					include_surrounding_whitespace = false,
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>z"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>a"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
