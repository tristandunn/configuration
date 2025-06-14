return {
  cmd                 = { "vscode-json-language-server", "--stdio" },
  capabilities        = require("cmp_nvim_lsp").default_capabilities(),
  filetypes           = { "json" },
  init_options        = { provideFormatter = true },
  root_markers        = { ".git" },
  single_file_support = true
}
