return {
  cmd          = { "rubocop", "--lsp" },
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  filetypes    = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}
