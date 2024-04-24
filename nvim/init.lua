-- General {{{
-- Assume POSIX shell in vim.
vim.g.is_posix      = true

vim.opt.mouse       = "a"   -- Enable mouse support in all modes.
vim.opt.swapfile    = false -- No swap files.
vim.opt.writebackup = false -- Don't write backup files.
-- }}}
-- Colors {{{
-- Enable syntax highlighting based on file type.
vim.opt.syntax      = "on"

-- Enable custom color scheme.
vim.cmd("colorscheme ir_black")
-- }}}
-- Spacing {{{
vim.opt.tabstop     = 2    -- Two spaces for tab.
vim.opt.softtabstop = 2    -- Two spaces for soft tabs.
vim.opt.expandtab   = true -- Spaces for tab.
vim.opt.shiftwidth  = 2    -- Two space indenting.

-- Display extra whitespace.
vim.opt.list        = true
vim.opt.listchars   = "tab:»·,trail:·"

-- Automatically strip trailing whitespace from buffer on save.
vim.api.nvim_create_autocmd(
  { "BufWritePre" },
  {
    pattern  = { "*" },
    callback = function()
      -- Save the current cursor position.
      local previous_cursor = vim.fn.getpos(".")

      -- Strip trailing whitespace from the buffer.
      vim.cmd([[%s/\s\+$//e]])

      -- Restore the previous cursor position.
      vim.fn.setpos(".", previous_cursor)
    end
  }
)
-- }}}
-- Formats {{{
-- Enable spell check and set text width for Markdown files.
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern  = { "*md", "*.markdown" },
    callback = function()
      vim.opt_local.spell     = true
      vim.opt_local.textwidth = 80
    end
  }
)

-- Enable spell check and set text width for commit messages.
vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern  = { "gitcommit" },
    callback = function()
      vim.opt_local.spell     = true
      vim.opt_local.textwidth = 80
    end
  }
)
-- }}}
-- Layout {{{
vim.opt.showmode    = false -- Disable mode in status line.
vim.opt.number      = true  -- Show line numbers.
vim.opt.numberwidth = 5     -- Width of gutter for line numbers.
vim.opt.scrolloff   = 4     -- Vertical line buffer when scrolling.
-- }}}
-- Shortcuts {{{
-- Leader is space.
vim.g.mapleader     = " "

-- Copy selection to the clipboard.
vim.keymap.set("v", "<Leader>c", "\"+y")

-- Duplicate a selection.
vim.keymap.set("v", "D", "y'>p")

-- Hide search highlighting.
vim.keymap.set("n", "<Leader>h", ":nohl<CR>")

-- Quickly escape to move up and down.
vim.keymap.set("i", "jj", "<ESC>j")
vim.keymap.set("i", "kk", "<ESC>k")

-- Shortcuts for Rails commands.
vim.keymap.set("n", "<Leader>bo", ":ExecuteCommandInPane bundle\\ outdated 0 0 2<CR>")
vim.keymap.set("n", "<Leader>r", ":ExecuteCommandInPane rubocop 0 0 2<CR>")
vim.keymap.set("n", "<Leader>rc", ":ExecuteCommandInPane bundle\\ exec\\ rake\\ check 0 0 2<CR>")
vim.keymap.set("n", "<Leader>yo", ":ExecuteCommandInPane yarn\\ outdated 1 0 2<CR>")

-- Tab shortcuts.
vim.keymap.set("n", "<Leader>w", ":quit<CR>")
vim.keymap.set("n", "<Leader>[", ":tabprevious<CR>")
vim.keymap.set("n", "<Leader>]", ":tabnext<CR>")
vim.keymap.set("n", "<Leader>1", ":tabn 1<CR>")
vim.keymap.set("n", "<Leader>2", ":tabn 2<CR>")
vim.keymap.set("n", "<Leader>3", ":tabn 3<CR>")
vim.keymap.set("n", "<Leader>4", ":tabn 4<CR>")
vim.keymap.set("n", "<Leader>5", ":tabn 5<CR>")
vim.keymap.set("n", "<Leader>6", ":tabn 6<CR>")
vim.keymap.set("n", "<Leader>7", ":tabn 7<CR>")
vim.keymap.set("n", "<Leader>8", ":tabn 8<CR>")
vim.keymap.set("n", "<Leader>9", ":tabn 9<CR>")
vim.keymap.set("n", "<Leader>0", ":tablast<CR>")

-- Shortcuts for CMD+S forwarding support.
vim.keymap.set("n", "<C-S>", ":update<CR>")
vim.keymap.set("v", "<C-S>", "<C-C>:update<CR>")
vim.keymap.set("i", "<C-S>", "<C-O>:update<CR>")

-- Opens an edit command with the path of the currently edited file filled in.
vim.keymap.set("n", "<Leader>e", ":e +9 <C-R>=escape(expand(\"%:p:h\") . \"/\", \" \") <CR>")

-- Opens a tab edit command with the path of the currently edited file filled in.
vim.keymap.set("n", "<Leader>te", ":tabe +9 <C-R>=escape(expand(\"%:p:h\") . \"/\", \" \") <CR>")
-- }}}
-- Miscellaneous {{{
-- Case only matters with mixed case expressions.
vim.opt.ignorecase    = true
vim.opt.smartcase     = true

-- Hide uncommon directories and files.
vim.g.netrw_list_hide = table.concat({
  "^\\.bundle\\/",
  "^\\.dockerignore",
  "^\\.eslintignore$",
  "^\\.eslintrc$",
  "^\\.jekyll-assets-cache\\/",
  "^\\.jekyll-cache\\/",
  "^\\.git\\/",
  "^\\.gitattributes",
  "^\\.gitignore$",
  "^\\.lighthouseci",
  "^\\.netlify",
  "^\\.pryrc$",
  "^\\.rspec$",
  "^\\.ruby-lsp\\/$",
  "^\\.yarn",
  "^\\.yarnrc",
  "^\\.\\/$",
  "^_site\\/$",
  "^coverage\\/$",
  "^Gemfile.lock",
  "^node_modules\\/$",
  "^tags$",
  "^tmp\\/$",
  "^yarn.lock"
}, ",")
-- }}}
-- tmux {{{
-- Remap NetrwRefresh to allow <C-l> to be used by nvim-tmux-navigation.
vim.keymap.set("n", "<leader><leader><leader><leader><leader><leader>l", "<Plug>NetrwRefresh")

--- Define function to execute command in specific tmux pane.
vim.api.nvim_create_user_command(
  "ExecuteCommandInPane",
  function(opts)
    local args = opts.fargs

    -- Ensure a command was provided.
    if args[1] == nil then
      vim.api.nvim_echo(
        { { "ExecuteCommandInPane: No command provided.", "WarningMsg" } },
        false,
        {}
      )

      return 0
    end

    local focus    = #args < 2 and 0 or args[2]
    local zoom     = #args < 3 and 0 or args[3]
    local pane     = #args < 4 and 2 or args[4]

    -- Create the call to run the provided command.
    local commands = "tmux " ..
        "send-keys -t " .. pane .. " " .. vim.fn.fnameescape(args[1]) .. " Enter"

    -- Add a command to focus the pane if requested.
    if focus == "1" then
      commands = commands .. " \\; select-pane -t " .. pane
    end

    -- Add a command to zoom the pane if requested.
    if zoom == "1" then
      commands = commands .. " \\; resize-pane -t " .. pane .. " -Z"
    end

    -- Cancel the current command and clear the pane.
    vim.fn.system("tmux send-keys -t " .. pane .. " C-c clear Enter")

    -- Wait for the pane to be cleared and execute the commands.
    vim.defer_fn(function()
      vim.fn.system(commands)
    end, 5)
  end,
  { desc = "Run a command in a specific tmux pane.", nargs = "*" }
)
-- }}}
-- Package Manager {{{
-- Determine the package manager path.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install the package manager, if missing.
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Add the package manager to the runtime path.
vim.opt.rtp:prepend(lazypath)
--- }}}
-- Plug-ins {{{
-- Install plug-ins with the package manager.
require("lazy").setup({
  -- Navigation for tmux panes.
  {
    "alexghergh/nvim-tmux-navigation",
    config = true,
    opts   = require("plug-ins.tmux-navigation").opts
  },

  -- File modification gutter.
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    init   = require("plug-ins.gitsigns").init,
    opts   = require("plug-ins.gitsigns").opts
  },

  -- LSP configurations.
  {
    "neovim/nvim-lspconfig",
    dependencies = require("plug-ins.lspconfig").dependencies,
    init         = require("plug-ins.lspconfig").init
  },

  -- File finder.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = require("plug-ins.telescope").dependencies,
    config       = true,
    init         = require("plug-ins.telescope").init,
    opts         = require("plug-ins.telescope").opts
  },

  -- File mapping projections.
  {
    "tpope/vim-projectionist",
    init = require("plug-ins.projectionist").init
  },

  -- Test runner.
  {
    "vim-test/vim-test",
    init = require("plug-ins.test").init
  },

  -- Automatically end certain code structures.
  {
    "tpope/vim-endwise"
  },

  -- Rails helpers.
  {
    "tpope/vim-rails"
  }
}, {
  -- Enable automatically checking for plug-in updates.
  checker = {
    enabled = true,
    frequency = 86400
  }
})
-- }}}

-- vim:foldmethod=marker:foldlevel=0
