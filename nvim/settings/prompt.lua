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
        local count  = vim.api.nvim_buf_line_count(buffer)

        -- Determine the relative path for the selection.
        local path   = vim.fn.fnamemodify(selection.path, ":.")

        -- Insert the path marker on the current line.
        vim.api.nvim_buf_set_lines(buffer, row - 1, row, false, { "@" .. path })

        -- Insert an empty line when needed.
        if count == row then
          vim.api.nvim_buf_set_lines(buffer, row, row, false, { "" })
        end

        -- Move the cursor to the next line.
        vim.api.nvim_win_set_cursor(window, { row + 1, 0 })

        -- Ensure the buffer is in insert mode.
        vim.schedule(function()
          vim.cmd("startinsert")
        end)
      end)

      -- Close the selector with Escape.
      map("i", "<ESC>", function()
        actions.close(prompt)

        local buffer = vim.api.nvim_get_current_buf()
        local window = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(window)
        local row    = cursor[1]

        -- Clear the line.
        vim.api.nvim_buf_set_lines(buffer, row - 1, row, false, { "" })

        -- Ensure the buffer is in insert mode.
        vim.schedule(function()
          vim.cmd("startinsert")
        end)
      end)

      return true
    end
  })
end

vim.api.nvim_create_user_command(
  "OpenLLMPrompt",
  function()
    local path   = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
    local buffer = vim.api.nvim_create_buf(false, true)
    local width  = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)

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
    vim.api.nvim_buf_set_option(buffer, "filetype", "markdown")

    -- Disable line numbers.
    vim.cmd("set nonumber")

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

    -- Submit the buffer to the LLM on Enter.
    set("n", "<CR>", function()
      local input = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)

      input = table.concat(input, "\\n")
      input = input:gsub("#buffer", "@" .. vim.fn.fnamemodify(path, ":."))
      input = vim.fn.shellescape(input)
      input = vim.fn.escape(input, " ")

      if input ~= "''" then
        vim.cmd(":ExecuteCommandInPane echo\\ " .. input .. "\\ |\\ supermods")
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
