return {
  cmd                 = { "yaml-language-server", "--stdio" },
  capabilities        = require("blink.cmp").get_lsp_capabilities(),
  filetypes           = { "eruby.yaml", "yaml" },
  root_markers        = { "Gemfile", "package.json" },
  single_file_support = true,
  settings            = { redhat = { telemetry = { enabled = false } } }
}
