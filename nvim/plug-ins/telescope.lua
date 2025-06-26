return {
  dependencies = {
    "BurntSushi/ripgrep",   -- Support for grep_string and live_grep.
    "nvim-lua/plenary.nvim" -- Require utility functions.
  },

  init = function()
    local builtin = require("telescope.builtin")
    local set     = vim.keymap.set

    -- Find a file.
    set("n", "<Leader>p", builtin.find_files)

    -- Find a word.
    set("n", "<Leader>j", function()
      local word = vim.fn.expand("<cword>")

      builtin.grep_string({ default_text = word })
    end)
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
