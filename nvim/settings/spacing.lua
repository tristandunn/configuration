local autocmd = vim.api.nvim_create_autocmd
local option  = vim.opt


option.expandtab   = true -- Spaces for tab.
option.shiftwidth  = 2    -- Two space indenting.
option.softtabstop = 2    -- Two spaces for soft tabs.
option.tabstop     = 2    -- Two spaces for tab.


-- Display tabs and trailing spaces.
option.list      = true
option.listchars = "tab:»·,trail:·"


-- Automatically strip trailing spaces from buffer on save.
autocmd(
  { "BufWritePre" },
  {
    pattern  = { "*" },
    callback = function()
      -- Save the current cursor position.
      local previous_cursor = vim.fn.getpos(".")

      -- Strip trailing spaces from the buffer.
      vim.cmd([[%s/\s\+$//e]])

      -- Restore the previous cursor position.
      vim.fn.setpos(".", previous_cursor)
    end
  }
)
