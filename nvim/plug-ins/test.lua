return {
  init = function()
    local set = vim.keymap.set

    -- Run the last test.
    set("n", "<Leader>l", ":TestLast<CR>")

    -- Run the nearest test.
    set("n", "<Leader>n", ":TestNearest<CR>")

    -- Run the full test suite.
    set("n", "<Leader>s", ":TestSuite<CR>")

    -- Run tests for the current file.
    set("n", "<Leader>f", ":TestFile<CR>")

    -- Use a custom pane runner.
    vim.api.nvim_set_var("test#custom_strategies", { pane = vim.cmd.ExecuteCommandInPane })
    vim.api.nvim_set_var("test#strategy", "pane")
  end
}
