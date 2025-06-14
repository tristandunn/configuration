local global  = vim.g
local set     = vim.keymap.set
local usercmd = vim.api.nvim_create_user_command


-- Space is the leader key.
global.mapleader = " "

-- Copy selection to the clipboard.
vim.keymap.set("v", "<Leader>c", "\"+y")

-- Duplicate a selection.
set("v", "D", "y'>p")

-- Hide search highlighting.
set("n", "<Leader>h", ":nohl<CR>")

-- Tab shortcuts.
set("n", "<Leader>w", ":quit<CR>")
set("n", "<Leader>[", ":tabprevious<CR>")
set("n", "<Leader>]", ":tabnext<CR>")
set("n", "<Leader>1", ":tabn 1<CR>")
set("n", "<Leader>2", ":tabn 2<CR>")
set("n", "<Leader>3", ":tabn 3<CR>")
set("n", "<Leader>4", ":tabn 4<CR>")
set("n", "<Leader>5", ":tabn 5<CR>")
set("n", "<Leader>6", ":tabn 6<CR>")
set("n", "<Leader>7", ":tabn 7<CR>")
set("n", "<Leader>8", ":tabn 8<CR>")
set("n", "<Leader>9", ":tabn 9<CR>")
set("n", "<Leader>0", ":tablast<CR>")

-- Opens an edit command with the path of the currently edited file filled in.
set("n", "<Leader>e", ":e +9 <C-R>=escape(expand(\"%:p:h\") . \"/\", \" \") <CR>")

-- Opens a tab edit command with the path of the currently edited file filled in.
set("n", "<Leader>te", ":tabe +9 <C-R>=escape(expand(\"%:p:h\") . \"/\", \" \") <CR>")

-- Shortcuts for CMD+S forwarding support.
set("n", "<C-S>", ":update<CR>")
set("v", "<C-S>", "<C-C>:update<CR>")
set("i", "<C-S>", "<C-O>:update<CR>")

-- Shortcuts for Rails commands.
set("n", "<Leader>bo", ":ExecuteCommandInPane bundle\\ outdated 0 0 2<CR>")
set("n", "<Leader>bu", ":ExecuteCommandInPane bundle\\ update 0 0 2<CR>")
set("n", "<Leader>r", ":ExecuteCommandInPane rubocop 0 0 2<CR>")
set("n", "<Leader>rc", ":ExecuteCommandInPane bundle\\ exec\\ rake\\ check 0 0 2<CR>")
set("n", "<Leader>yo", ":ExecuteCommandInPane yarn\\ outdated 1 0 2<CR>")

-- Remap NetrwRefresh to allow <C-l> to be used by nvim-tmux-navigation.
set("n", "<leader><leader><leader><leader><leader><leader>l", "<Plug>NetrwRefresh")

-- Define function to execute command in specific tmux pane.
usercmd(
  "ExecuteCommandInPane",
  function(opts)
    local args  = opts.fargs
    local focus = #args < 2 and 0 or args[2]
    local zoom  = #args < 3 and 0 or args[3]
    local pane  = #args < 4 and 2 or args[4]

    -- Ensure a command was provided.
    if args[1] == nil then
      vim.api.nvim_echo(
        { { "ExecuteCommandInPane: No command provided.", "WarningMsg" } },
        false,
        {}
      )

      return 0
    end

    -- Create the call to run the provided command.
    local commands = "tmux " .. "send-keys -t " .. pane .. " " .. vim.fn.fnameescape(args[1]) .. " Enter"

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
