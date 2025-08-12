local set = vim.keymap.set

local function pick_file_and_insert()
  local actions = require("telescope.actions")
  local state   = require("telescope.actions.state")
  local builtin = require("telescope.builtin")

  builtin.find_files({
    attach_mappings = function(prompt, map)
      -- Select the file with Enter.
      map("i", "<CR>", function()
        local selection = state.get_selected_entry()

        if not selection then
          return
        end

        -- Close the finder.
        actions.close(prompt)

        local buffer = vim.api.nvim_get_current_buf()
        local window = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(window)
        local row    = cursor[1]
        local col    = cursor[2]

        -- Determine the relative path for the selection.
        local path = vim.fn.fnamemodify(selection.path, ":.")

        -- Get the current line content.
        local line = vim.api.nvim_buf_get_lines(buffer, row - 1, row, false)[1] or ""

        -- Insert the path at the current position.
        line = line:sub(1, col) .. path .. " " .. line:sub(col + 1)

        -- Update the line.
        vim.api.nvim_buf_set_lines(buffer, row - 1, row, false, { line })

        -- Move the cursor to after the inserted path and space.
        vim.api.nvim_win_set_cursor(window, { row, col + #path + 1  })

        -- Ensure the buffer is in insert mode.
        vim.schedule(function()
          vim.api.nvim_feedkeys("a", "n", false)
        end)
      end)

      -- Close the selector with Escape.
      map("i", "<ESC>", function()
        actions.close(prompt)

        local buffer = vim.api.nvim_get_current_buf()
        local window = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(window)
        local row    = cursor[1]
        local col    = cursor[2]

        -- Get the current line content.
        local line = vim.api.nvim_buf_get_lines(buffer, row - 1, row, false)[1] or ""

        -- Remove the @ from the line.
        line = line:sub(1, col - 1) .. line:sub(col + 1)

        -- Update the line.
        vim.api.nvim_buf_set_lines(buffer, row - 1, row, false, { line })

        -- Move the cursor to after
        vim.api.nvim_win_set_cursor(window, { row, col - 1 })

        -- Ensure the buffer is in insert mode.
        vim.schedule(function()
          vim.api.nvim_feedkeys("a", "n", false)
        end)
      end)

      return true
    end
  })
end

vim.api.nvim_create_user_command(
  "OpenLLMPrompt",
  function()
    local buffer    = vim.api.nvim_create_buf(false, true)
    local height    = math.floor(vim.o.lines * 0.6)
    local mode      = vim.fn.mode()
    local path      = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    local selection = ""
    local width     = math.floor(vim.o.columns * 0.8)

    -- When in visual mode, get the path and position to start as the prompt.
    if mode == "v" or mode == "V" or mode == "\22" then
      -- Retrieve the selected lines and relative path.
      local start    = vim.fn.getpos("'<")
      local stop     = vim.fn.getpos("'>")
      local relative = vim.fn.fnamemodify(path, ":.")

      start     = start[2]
      stop      = stop[2]
      selection = "@" .. relative .. ":" .. start .. "-" .. stop .. "\n"
    end

    -- Create a floating window with the temporary buffer.
    local window = vim.api.nvim_open_win(buffer, true, {
      border   = "rounded",
      col      = math.floor((vim.o.columns - width) / 2),
      height   = height,
      relative = "editor",
      row      = math.floor((vim.o.lines - height) / 2),
      title    = " Prompt ",
      width    = width
    })

    -- Set the buffer file type to Markdown.
    vim.bo[buffer].filetype = "markdown"

    -- Disable line numbers.
    vim.wo[window].number   = false

    -- Insert selection text if available.
    if selection ~= "" then
      vim.api.nvim_buf_set_lines(buffer, 0, 0, false, vim.split(selection, "\n"))
    end

    -- Start in insert mode.
    vim.cmd("startinsert")

    -- Insert file paths to include content.
    set("i", "@", function()
      -- Insert the @ symbol.
      vim.api.nvim_feedkeys("@", "n", false)

      -- Trigger the file picker.
      vim.schedule(function()
        pick_file_and_insert()
      end)
    end, { buffer = buffer })

    -- Insert current buffer path when # is typed.
    set("i", "#", function()
      local relative = vim.fn.fnamemodify(path, ":.")

      if relative ~= "" then
        vim.api.nvim_feedkeys("@" .. relative .. " ", "n", false)
      end
    end, { buffer = buffer })

    -- Submit the buffer to the LLM on Enter.
    set("n", "<CR>", function()
      local input = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

      input = table.concat(input, "\n")
      input = input:gsub("#buffer", "@" .. vim.fn.fnamemodify(path, ":."))

      -- When present, send the input via tmux and then submit.
      if input ~= "" then
        vim.fn.system({ "tmux", "send-keys", "-t", "2", input })
        vim.fn.system({ "tmux", "send-keys", "-t", "2", "Enter" })
      end

      -- Close the window.
      vim.api.nvim_win_close(window, true)
    end, { buffer = buffer })

    -- Close the prompt on Escape.
    set("n", "<ESC>", function()
      -- Close the window.
      vim.api.nvim_win_close(window, true)
    end, { buffer = buffer })
  end,
  {}
)

set("n", "<Leader>ll", "<Cmd>OpenLLMPrompt<CR>")
set("v", "<Leader>ll", "<Cmd>OpenLLMPrompt<CR>")

for index = 1, 3 do
  set("n", "<Leader>l" .. tostring(index), function()
    vim.fn.system({"tmux", "send-keys", "-t", "2", tostring(index)})
    vim.fn.system({"tmux", "send-keys", "-t", "2", "Enter"})

    -- Open prompt to respond when rejecting a change.
    if index == 3 then
      vim.schedule(function()
        vim.cmd("OpenLLMPrompt")
      end)
    end
  end)
end
