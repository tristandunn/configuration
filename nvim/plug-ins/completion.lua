return {
  options = {
    cmdline = {
      enabled = false
    },

    completion = {
      list = {
        selection = {
          -- Don't automatically select the first item.
          preselect = false
        }
      }
    },

    keymap = {
      -- Use the preset that uses Enter to accept.
      preset = "enter",

      -- Modify the Tab shortcut to select the next item.
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_next()
          end
        end,

        "snippet_forward",
        "fallback"
      },

      -- Modify the Shift+Tab shortcut to select the next item.
      ["<S-Tab>"] = { "select_prev", "fallback" }
    },

    sources = {
      -- Require two characters to display completion.
      min_keyword_length = 3,

      providers = {
        -- Ensure the buffer source is always shown.
        lsp = { fallbacks = {} }
      }
    }
  }
}
