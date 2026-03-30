require("settings.init")
require("plug-ins.init")

-- Enable LSP servers.
vim.lsp.enable({
  "docker",
  "erb",
  "eslint",
  "json",
  "lua",
  "ruby",
  "rubocop",
  "stylelint",
  "tailwindcss",
  "yaml"
})
