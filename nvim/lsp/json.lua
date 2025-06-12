return {
  cmd                 = { "vscode-json-language-server", "--stdio" },
  capabilities        = require("blink.cmp").get_lsp_capabilities(),
  filetypes           = { "json" },
  init_options        = { provideFormatter = true },
  root_markers        = { ".git" },
  single_file_support = true
}
