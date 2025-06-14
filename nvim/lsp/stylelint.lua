return {
  cmd          = { "stylelint-lsp", "--stdio" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes    = { "css", "html" },
  root_markers = { ".stylelintignore", ".stylelintrc.js" },
  settings     = { stylelintplus = { autoFixOnFormat = true } }
}
