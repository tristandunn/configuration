-- Add default border and maximum dimensions to floating previews.
local open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, options, ...)
  options            = options or {}
  options.border     = options.border or "rounded"
  options.max_height = options.max_height or 24
  options.max_width  = options.max_width or 110

  return open_floating_preview(contents, syntax, options, ...)
end

-- Add additional shortcuts for LSP commands.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buf    = vim.lsp.buf
    local buffer = event.buf
    local set    = vim.keymap.set

    -- Add shortcuts for definition and declaration.
    set("n", "gd", buf.definition, { buffer = buffer, silent = true })
    set("n", "grd", buf.declaration, { buffer = buffer, silent = true })

    -- Format selection.
    set({ "n", "x" }, "gq", function()
      buf.format({ async = true, bufnr = buffer })
    end, { buffer = buffer, silent = true })
  end
})

vim.diagnostic.config({
  -- Update diagnostics in insert mode.
  update_in_insert = true,

  -- Always display diagnostics inline as virtual text.
  virtual_text = {
    source = "always"
  }
})

-- Enable LSP servers.
vim.lsp.enable({
  "docker",
  "erb",
  "eslint",
  "json",
  "lua",
  "ruby",
  "rubocop",
  "stylelint",
  "tailwindcss",
  "yaml"
})
