return {
  init = function()
    -- Disable the default tab completion.
    vim.g.copilot_no_tab_map = true

    -- Customize which file types it completes.
    vim.g.copilot_filetypes = {
      ["*"]      = false,
      javascript = true,
      lua        = true,
      ruby       = true,
    }

    -- Use <C-Y> to accept a completion.
    vim.keymap.set("i", "<C-Y>", "copilot#Accept(\"\\<CR>\")", {
      expr             = true,
      replace_keycodes = false
    })
  end
}
