return {
  dependencies = {
    "BurntSushi/ripgrep",   -- Support for grep_string and live_grep.
    "nvim-lua/plenary.nvim" -- Require utility functions.
  },

  init = function()
    local set = vim.keymap.set

    -- Find a file.
    set("n", "<Leader>p", "<Cmd>Telescope find_files<CR>")

    -- Find a word.
    set("n", "<Leader>j", "<Cmd>Telescope grep_string search=<C-R><C-W><CR>")
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
