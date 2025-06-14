return {
  dependencies = {
    "hrsh7th/cmp-buffer",   -- Buffer completion.
    "hrsh7th/cmp-nvim-lsp", -- LSP completion.
    "hrsh7th/cmp-path"      -- File path completion.
  },

  init = function()
    local cmp = require("cmp")

    cmp.setup({
      formatting = {
        -- Only display the label and the kind of completion.
        fields = { "abbr", "kind" },

        -- Truncate the label to 32 characters.
        format = function(_, item)
          item.abbr = string.sub(item.abbr, 1, 32)

          return item
        end
      },

      mapping = cmp.mapping.preset.insert({
        -- Manually trigger completion.
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Use the current completion.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Move to the next completion item or fallback to default behavior.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Move to the previous completion item or fallback to default behavior.
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Scroll through the documentation.
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4)
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },

        {
          name   = "buffer",
          option = {
            -- Use all loaded buffers for completions.
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },

        { name = "path" }
      })
    })
  end
}
