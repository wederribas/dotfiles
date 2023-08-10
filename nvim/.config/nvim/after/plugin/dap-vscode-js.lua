require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
  adapters = {
    'pwa-node',
    'pwa-chrome',
    'pwa-msedge',
    'node-terminal',
    'pwa-extensionHost',
  },
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "typescriptreact" }
for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
      {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
      },
      {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
      },
      {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Remote Port",
          protocol = "inspector",
          host = "0.0.0.0",
          port = os.getenv("NODEJS_DEBUGGER_PORT") or 9229,
          cwd = vim.fn.getcwd(),
          localRoot = vim.fn.getcwd(),
          remoteRoot = "/usr/local/bim360",
          console = "integratedTerminal",
          resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**"
          },
      },
      {
          type = "pwa-chrome",
          request = "launch",
          name = "Start Chrome with \"localhost\"",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
      }
  }
end

