local autocmd = vim.api.nvim_create_autocmd

-- Enable spell check and set text width for commit messages and markdown.
autocmd(
  { "FileType" },
  {
    pattern  = { "gitcommit", "markdown", "text" },
    callback = function()
      vim.opt_local.spell     = true
      vim.opt_local.textwidth = 80
    end
  }
)
