return {
  cmd          = { "ruby-lsp" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  init_options = { formatter = "auto" },
  filetypes    = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".git" }
}
