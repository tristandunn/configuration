local autocmd = vim.api.nvim_create_autocmd

-- Enable spell check and set text width for commit messages.
autocmd(
  { "FileType" },
  {
    pattern  = { "gitcommit" },
    callback = function()
      vim.opt_local.spell     = true
      vim.opt_local.textwidth = 80
    end
  }
)

-- Enable spell check and set text width for Markdown files.
autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern  = { "*md", "*.markdown" },
    callback = function()
      vim.opt_local.spell     = true
      vim.opt_local.textwidth = 80
    end
  }
)
