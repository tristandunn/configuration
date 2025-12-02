-- Disable window animations.
hs.window.animationDuration = 0

-- Move window to the center of the screen.
function hs.window.center(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)

  window:setFrame(frame)
end

-- Resize window to 80% of the screen and center.
function hs.window.default(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.w = (screen.w / 10) * 8
  frame.h = (screen.h / 10) * 8
  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)

  window:setFrame(frame)
end

-- Move and resize the window to the bottom half of the screen.
function hs.window.bottom(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y + (screen.h / 2)
  frame.w = screen.w
  frame.h = screen.h / 2

  window:setFrame(frame)
end

-- Decrease the window size by 10% of the screen size.
function hs.window.decrease(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = frame.x + (screen.w * 0.05)
  frame.y = frame.y + (screen.h * 0.05)
  frame.w = frame.w - (screen.w * 0.1)
  frame.h = frame.h - (screen.h * 0.1)

  window:setFrame(frame)
end

-- Increase the window size by 10% of the screen size.
function hs.window.increase(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = frame.x - (screen.w * 0.05)
  frame.y = frame.y - (screen.h * 0.05)
  frame.w = frame.w + (screen.w * 0.1)
  frame.h = frame.h + (screen.h * 0.1)

  window:setFrame(frame)
end

-- Move and resize the window to the left half of the screen.
function hs.window.left(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y
  frame.w = screen.w / 2
  frame.h = screen.h

  window:setFrame(frame)
end

-- Resize window to 100% of the screen.
function hs.window.fullscreen(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.w = screen.w
  frame.h = screen.h
  frame.x = 0
  frame.y = 0

  window:setFrame(frame)
end

-- Move and resize the window to the right half of the screen.
function hs.window.right(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x + (screen.w / 2)
  frame.y = screen.y
  frame.w = screen.w / 2
  frame.h = screen.h

  window:setFrame(frame)
end

-- Move and resize the window to the top half of the screen.
function hs.window.top(window)
  local frame = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y
  frame.w = screen.w
  frame.h = screen.h / 2

  window:setFrame(frame)
end

-- Menu bar indicator for recording.
local recordingIndicator = nil
local recordingTimer = nil

-- Run the record command.
function hs.window.record(_)
  -- Ignore if already recording.
  if recordingIndicator then
    return
  end

  -- Show menu bar indicator for recording.
  recordingIndicator = hs.menubar.new()
  recordingIndicator:setTitle(hs.styledtext.new("●", {color = {red = 1, green = 0, blue = 0}}))

  -- Poll for transcribing state to change menu bar indicator state.
  recordingTimer = hs.timer.doEvery(0.2, function()
    if hs.fs.attributes("/tmp/record-transcribing") and recordingIndicator then
      recordingIndicator:setTitle(hs.styledtext.new("●", {color = {red = 0.2, green = 0.5, blue = 1}}))
    end
  end)

  local task = hs.task.new(
    "~/.configuration/bin/record",
    function(exitCode, stdout, _)
      -- Ensure the timer is stopped.
      if recordingTimer then
        recordingTimer:stop()
        recordingTimer = nil
      end

      -- Ensure the indicator is removed.
      if recordingIndicator then
        recordingIndicator:delete()
        recordingIndicator = nil
      end

      if exitCode == 0 and stdout ~= "" then
        local text  = stdout:gsub("%s+$", "")
        local enter = false

        -- Check if text ends with "enter" and remove it.
        if text:lower():match("enter[%.!?%s]*$") then
          text  = text:gsub("[%.!?%s]*[Ee][Nn][Tt][Ee][Rr][%.!?%s]*$", "")
          enter = true
        end

        -- Send the text.
        hs.eventtap.keyStrokes(text)

        -- Submit the text.
        if enter then
          hs.timer.doAfter(0.1, function()
            local app = hs.application.frontmostApplication()
            local name = app and app:name() or ""

            if name == "kitty" then
              hs.eventtap.keyStroke({"cmd"}, "return")
            else
              hs.eventtap.keyStroke({}, "return")
            end
          end)
        end
      elseif exitCode ~= 0 then
        hs.alert.show("Error: " .. exitCode)
      end
    end
  )

  task:start()
end

-- Create a window layout mode.
local windowLayoutModal = hs.hotkey.modal.new({}, "F16")

-- Bind the given key to call the given function and exit the window layout mode.
function windowLayoutModal.bindWithAutomaticExit(modal, modifiers, key, fn)
  modal:bind(modifiers, key, nil, function()
    modal:exit()
    fn()
  end)
end

-- Load the window bindings.
local _, bindings = pcall(require, "keyboard.windows-bindings")

-- Bind the window bindings to the window layout mode and exit after execution.
for _, mapping in ipairs(bindings.mappings) do
  local modifiers, trigger, method = table.unpack(mapping)

  windowLayoutModal:bindWithAutomaticExit(modifiers, trigger, function()
    local focusedWindow = hs.window.focusedWindow()

    hs.window[method](focusedWindow)
  end)
end

local modifiers = bindings.modifiers
local trigger = bindings.trigger

-- Use modifiers+trigger to toggle the window layout mode.
hs.hotkey.bind(modifiers, trigger, function()
  windowLayoutModal:enter()
end)
windowLayoutModal:bind(modifiers, trigger, function()
  windowLayoutModal:exit()
end)
