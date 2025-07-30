return {
  cmd                 = { "yaml-language-server", "--stdio" },
  capabilities        = require("blink.cmp").get_lsp_capabilities(),
  filetypes           = { "eruby.yaml", "yaml" },
  root_markers        = { "Gemfile", "package.json" },
  single_file_support = true,
  settings            = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = {
        ["https://www.rubyschema.org/i18n/locale.json"]     = "locale/*.yml",
        ["https://www.rubyschema.org/kamal/deploy.json"]    = "deploy.yml",
        ["https://www.rubyschema.org/rails/cable.json"]     = "cable.yml",
        ["https://www.rubyschema.org/rails/cache.json"]     = "cache.yml",
        ["https://www.rubyschema.org/rails/database.json"]  = "database.yml",
        ["https://www.rubyschema.org/rails/queue.json"]     = "queue.yml",
        ["https://www.rubyschema.org/rails/recurring.json"] = "recurring.yml",
        ["https://www.rubyschema.org/rails/storage.json"]   = "storage.yml",
        ["https://www.rubyschema.org/rubocop.json"]         = ".rubocop.yml"
      }
    }
  }
}
