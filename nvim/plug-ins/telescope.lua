return {
  dependencies = {
    "BurntSushi/ripgrep",   -- Support for grep_string and live_grep.
    "nvim-lua/plenary.nvim" -- Require utility functions.
  },

  init = function()
    -- Shortcuts.
    vim.keymap.set("n", "<Leader>p", ":Telescope find_files<CR>")
    vim.keymap.set("n", "<Leader>j", ":Telescope grep_string search=<C-R><C-W><CR>")
  end,

  opts = {
    defaults = {
      preview  = false,
      mappings = {
        i = {
          ["<CR>"] = "select_tab"
        }
      }
    },
    pickers = {
      find_files = {
        theme = "dropdown"
      },
      grep_string = {
        theme = "dropdown"
      }
    }
  }
}
