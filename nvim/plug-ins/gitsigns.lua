return {
  init = function()
    -- Shortcuts.
    vim.keymap.set("n", "<Leader>sb", "<ESC>:Gitsigns stage_buffer<CR>")
    vim.keymap.set("n", "<Leader>sh", "<ESC>:Gitsigns stage_hunk<CR>")
    vim.keymap.set("n", "<Leader>gdc", "<ESC>:ExecuteCommandInPane git\\ diff\\ --cached 1 1<CR>")
    vim.keymap.set("n", "<Leader>gdi", "<ESC>:ExecuteCommandInPane git\\ diff 1 1<CR>")
    vim.keymap.set("n", "<Leader>gp", "<ESC>:ExecuteCommandInPane git\\ pull 0 0 3<CR>")
    vim.keymap.set("n", "<Leader>gs", "<ESC>:ExecuteCommandInPane git\\ status 0 0 3<CR>")
  end,

  opts = {
    numhl = true,
    signs = {
      add          = { text = " +" },
      change       = { text = " ~" },
      delete       = { text = " -" },
      topdelete    = { text = " ‾" },
      changedelete = { text = " ~" },
      untracked    = { text = " ┆" }
    }
  }
}
