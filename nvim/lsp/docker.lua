return {
  cmd                 = { "docker-langserver", "--stdio" },
  capabilities        = require("cmp_nvim_lsp").default_capabilities(),
  filetypes           = { "dockerfile" },
  root_markers        = { "Dockerfile" },
  single_file_support = true
}
