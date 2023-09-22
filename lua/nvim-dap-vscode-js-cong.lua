
require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = vim.fn.stdpath('config') .. '\\autoload\\plugged\\vscode-js-debug',

  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = {
      'pwa-node',
      'pwa-chrome',
      'pwa-msedge',
      'node-terminal',
      'pwa-extensionHost',
      'node' 
  }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.

})


local js_based_languages = { "typescript", "javascript", "javascriptreact"}

for _, language in ipairs(js_based_languages) do
    require("dap").configurations[language] = {
    {
        name = "Launch file",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
        trace = true,
    },
    -- {
    --     name = "Attach",
    --     type = "pwa-node",
    --     request = "attach",
    --     processId = require 'dap.utils'.pick_process,
    --     console = "integratedTerminal",
    --     cwd = "${workspaceFolder}",
    -- },
    -- {
    --     name = "Start Chrome with \"localhost\"",
    --     type = "pwa-chrome",
    --     request = "launch",
    --     console = "integratedTerminal",
    --     url = "http://localhost:5000",
    --     webRoot = "${workspaceFolder}",
    --     userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
    -- }
}
end
