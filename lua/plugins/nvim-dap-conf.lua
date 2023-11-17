--- @diagnostic disable: missing-fields

return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"williamboman/mason.nvim",

		-- [[ Custom Debuggers ]]             -- Add your own debuggers here
		"mfussenegger/nvim-dap-python",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
	},

	config = function()
		require("nvim-dap-virtual-text").setup({})

		local dap = require("dap")
		local dapui = require("dapui")

		-- [[ Dap UI setup ]]
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more!
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- [[ Shortcuts ]]
		vim.keymap.set("n", "<F5>", dap.continue, {
			silent = false,
			noremap = true,
			desc = "Debug: Start/Continue.",
		})
		vim.keymap.set("n", "<F1>", dap.step_into, {
			silent = false,
			noremap = true,
			desc = "Debug: Step into.",
		})
		vim.keymap.set("n", "<F2>", dap.step_over, {
			silent = false,
			noremap = true,
			desc = "Debug: Step over.",
		})
		vim.keymap.set("n", "<F3>", dap.step_out, {
			silent = false,
			noremap = true,
			desc = "Debug: Step out.",
		})
		vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {
			silent = false,
			noremap = true,
			desc = "Debug: Toggle a [B]reakpoint.",
		})
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, {
			desc = "Debug: [D]ap set a [B]reakpoint with condition.",
		})
		vim.keymap.set("n", "<Leader>dr", dap.repl.open, {
			silent = false,
			noremap = true,
			desc = "Debug: [D]ap [R]epl open.",
		})
		vim.keymap.set("n", "<Leader>du", require("dapui").open, {
			silent = false,
			noremap = true,
			desc = "Debug: Open [D]ap [U]i.",
		})

		-- [[ Python condifuration ]]
		dap.adapters.python = function(callback, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				callback({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				callback({
					type = "executable",
					command = vim.fn.getenv("LOCALAPPDATA") .. "/Programs/Python/Python311/python",
					args = { "-m", "debugpy.adapter" },
					detached = true,
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.python = {
			{
				-- The first three options are required by nvim-dap
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Launch file",
				console = "internalConsole",

				-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
				program = "${file}", -- This configuration will launch the current file if used.
				pythonPath = function()
					-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
					-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
					-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return vim.fn.getenv("LOCALAPPDATA") .. "/Programs/Python/Python311/pythonw"
					end
				end,
			},
		}

		-- [[ JS configuration ]]
		require("dap-vscode-js").setup({
			-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			debugger_path = vim.fn.stdpath("data") .. "\\lazy\\vscode-js-debug",

			-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
			adapters = {
				"pwa-node",
				"pwa-chrome",
				"pwa-msedge",
				"node-terminal",
				"pwa-extensionHost",
				"node",
			}, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		})

		local js_based_languages = { "typescript", "javascript", "javascriptreact" }

		for _, language in ipairs(js_based_languages) do
			dap.configurations[language] = {
				{
					name = "Launch file",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
					trace = true,
				},
			}
		end
	end,
}
