return {
  cmd          = { "rubocop", "--lsp" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes    = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}
