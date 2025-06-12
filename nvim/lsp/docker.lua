return {
  cmd                 = { "docker-langserver", "--stdio" },
  capabilities        = require("blink.cmp").get_lsp_capabilities(),
  filetypes           = { "dockerfile" },
  root_markers        = { "Dockerfile" },
  single_file_support = true
}
