return {
  cmd          = { "herb-language-server", "--stdio" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  filetypes    = { "html", "eruby" },
  root_markers = { "Gemfile", ".git" }
}
