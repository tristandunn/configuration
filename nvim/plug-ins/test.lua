return {
  init = function()
    local set = vim.keymap.set

    -- Run the last test.
    set("n", "<Leader>l", "<Cmd>TestLast<CR>")

    -- Run the nearest test.
    set("n", "<Leader>n", "<Cmd>TestNearest<CR>")

    -- Run the full test suite.
    set("n", "<Leader>s", "<Cmd>TestSuite<CR>")

    -- Run tests for the current file.
    set("n", "<Leader>f", "<Cmd>TestFile<CR>")

    -- Use a custom pane runner.
    vim.api.nvim_set_var("test#custom_strategies", { pane = vim.cmd.ExecuteCommandInPane })
    vim.api.nvim_set_var("test#strategy", "pane")
  end
}
