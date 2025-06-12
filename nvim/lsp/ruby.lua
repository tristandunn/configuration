return {
  cmd          = { "ruby-lsp" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  init_options = { formatter = "auto" },
  filetypes    = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" }
}
