return {
  cmd          = { "tailwindcss-language-server", "--stdio" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes    = { "css", "erb", "eruby", "html", "javascript", "markdown" },
  root_markers = { "Gemfile", "tailwind.config.js" },
  settings     = {
    tailwindCSS = {
      classAttributes  = { "class", "className" },
      includeLanguages = { eruby = "erb" },
      validate         = true,
      lint             = {
        cssConflict              = "warning",
        invalidApply             = "error",
        invalidConfigPath        = "error",
        invalidScreen            = "error",
        invalidTailwindDirective = "error",
        invalidVariant           = "error",
        recommendedVariantOrder  = "warning",
      }
    }
  }
}
