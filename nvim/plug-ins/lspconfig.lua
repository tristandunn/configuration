return {
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
  },

  init = function()
    local cmp          = require("cmp")
    local lspconfig    = require("lspconfig")
    local luasnip      = require("luasnip")
    local select_opts  = { behavior = cmp.SelectBehavior.Select }
    local lsp_defaults = lspconfig.util.default_config

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      sources = {
        {
          name   = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end
          }
        },
        { name = "nvim_lsp" },
        { name = "luasnip" }
      },
      window = {
        documentation = cmp.config.disable
      },
      formatting = {
        fields = { "menu", "abbr", "kind" }
      },
      mapping = {
        ["<Up>"]    = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"]  = cmp.mapping.select_next_item(select_opts),

        ["<C-p>"]   = cmp.mapping.select_prev_item(select_opts),
        ["<C-n>"]   = cmp.mapping.select_next_item(select_opts),

        ["<C-u>"]   = cmp.mapping.scroll_docs(-4),
        ["<C-d>"]   = cmp.mapping.scroll_docs(4),

        ["<C-e>"]   = cmp.mapping.abort(),
        ["<CR>"]    = cmp.mapping.confirm({ select = false }),

        ["<C-f>"]   = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-b>"]   = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<Tab>"]   = cmp.mapping(function(fallback)
          local col = vim.fn.col(".") - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            fallback()
          else
            cmp.complete()
            cmp.select_next_item(select_opts)
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
    })

    -- Extend the default LSP capabilities with cmp-nvim-lsp capabilities.
    lsp_defaults.capabilities = vim.tbl_deep_extend(
      "force",
      lsp_defaults.capabilities,
      require("cmp_nvim_lsp").default_capabilities()
    )

    -- Set up LSP servers.
    lspconfig.eslint.setup({})
    lspconfig.jsonls.setup({})
    lspconfig.rubocop.setup({})
    lspconfig.ruby_lsp.setup({})
    lspconfig.stylelint_lsp.setup({})
    lspconfig.lua_ls.setup({
      on_init = function(client)
        client.notify(
          "workspace/didChangeConfiguration",
          { settings = client.config.settings }
        )

        return true
      end
    })

    -- Automatically format buffer with LSP when writing.
    vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
  end
}
