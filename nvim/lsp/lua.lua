return {
  cmd                 = { "lua-language-server" },
  capabilities        = require("blink.cmp").get_lsp_capabilities(),
  filetypes           = { "lua" },
  root_markers        = { ".luarc.json" },
  log_level           = vim.lsp.protocol.MessageType.Warning,
  single_file_support = true
}
