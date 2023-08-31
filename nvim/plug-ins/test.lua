return {
  init = function()
    -- Shortcuts.
    vim.keymap.set("n", "<Leader>l", ":TestLast<CR>")
    vim.keymap.set("n", "<Leader>n", ":TestNearest<CR>")
    vim.keymap.set("n", "<Leader>s", ":TestSuite<CR>")
    vim.keymap.set("n", "<Leader>f", ":TestFile<CR>")

    -- Use a custom pane runner.
    vim.api.nvim_set_var("test#custom_strategies", { pane = vim.cmd.ExecuteCommandInPane })
    vim.api.nvim_set_var("test#strategy", "pane")
  end
}
