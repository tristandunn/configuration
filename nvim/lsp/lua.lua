return {
  cmd                 = { "lua-language-server" },
  capabilities        = require("cmp_nvim_lsp").default_capabilities(),
  filetypes           = { "lua" },
  root_markers        = { ".luarc.json" },
  log_level           = vim.lsp.protocol.MessageType.Warning,
  single_file_support = true
}
