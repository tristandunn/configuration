return {
  init = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set("i", "<C-Y>", "copilot#Accept(\"\\<CR>\")", {
      expr = true,
      replace_keycodes = false
    })
  end
}
