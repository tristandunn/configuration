return {
  cmd          = { "stylelint-lsp", "--stdio" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  filetypes    = { "css", "html" },
  root_markers = { ".stylelintignore", ".stylelintrc.js" },
  settings     = { stylelintplus = { autoFixOnFormat = true } }
}
