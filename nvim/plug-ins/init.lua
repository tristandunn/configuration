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

-- Install plug-ins with the package manager.
require("lazy").setup({
  -- Navigation for tmux panes.
  {
    "alexghergh/nvim-tmux-navigation",
    config = true,
    opts   = require("plug-ins.tmux-navigation").opts
  },

  -- Completion.
  {
    "saghen/blink.cmp",
    version = "1.3.1",
    opts    = require("plug-ins.completion").options
  },

  -- Open file at line number.
  {
    "lewis6991/fileline.nvim"
  },

  -- File modification gutter.
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    init   = require("plug-ins.gitsigns").init,
    opts   = require("plug-ins.gitsigns").opts
  },

  -- File finder.
  {
    "nvim-telescope/telescope.nvim",
    dependencies = require("plug-ins.telescope").dependencies,
    config       = true,
    init         = require("plug-ins.telescope").init,
    opts         = require("plug-ins.telescope").opts
  },

  -- Automatically create directories when needed.
  {
    "pezcoder/auto-create-directory.nvim",
    init = function()
      require("auto-create-directory").setup()
    end
  },

  -- File mapping projections.
  {
    "tpope/vim-projectionist",
    init = require("plug-ins.projectionist").init
  },

  -- Automatically end certain code structures.
  {
    "tpope/vim-endwise"
  },

  -- Rails helpers.
  {
    "tpope/vim-rails"
  },

  -- Test runner.
  {
    "vim-test/vim-test",
    init = require("plug-ins.test").init
  }
}, {
  -- Enable automatically checking for plug-in updates.
  checker = {
    enabled   = true,
    frequency = 432000
  }
})
