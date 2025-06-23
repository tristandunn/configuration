return {
  cmd          = { "herb-language-server", "--stdio" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  filetypes    = { "html", "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" }
}
