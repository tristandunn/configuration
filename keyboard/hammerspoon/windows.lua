-- Disable window animations.
hs.window.animationDuration = 0

-- Move window to the center of the screen.
function hs.window.center(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)

  window:setFrame(frame)
end

-- Resize window to 80% of the screen and center.
function hs.window.default(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.w = (screen.w / 10) * 8
  frame.h = (screen.h / 10) * 8
  frame.x = (screen.w / 2) - (frame.w / 2)
  frame.y = (screen.h / 2) - (frame.h / 2)

  window:setFrame(frame)
end

-- Move and resize the window to the bottom half of the screen.
function hs.window.bottom(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y + (screen.h / 2)
  frame.w = screen.w
  frame.h = screen.h / 2

  window:setFrame(frame)
end

-- Decrease the window size by 10% of the screen size.
function hs.window.decrease(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = frame.x + (screen.w * 0.05)
  frame.y = frame.y + (screen.h * 0.05)
  frame.w = frame.w - (screen.w * 0.1)
  frame.h = frame.h - (screen.h * 0.1)

  window:setFrame(frame)
end

-- Increase the window size by 10% of the screen size.
function hs.window.increase(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = frame.x - (screen.w * 0.05)
  frame.y = frame.y - (screen.h * 0.05)
  frame.w = frame.w + (screen.w * 0.1)
  frame.h = frame.h + (screen.h * 0.1)

  window:setFrame(frame)
end

-- Move and resize the window to the left half of the screen.
function hs.window.left(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y
  frame.w = screen.w / 2
  frame.h = screen.h

  window:setFrame(frame)
end

-- Move and resize the window to the right half of the screen.
function hs.window.right(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x + (screen.w / 2)
  frame.y = screen.y
  frame.w = screen.w / 2
  frame.h = screen.h

  window:setFrame(frame)
end

-- Move and resize the window to the top half of the screen.
function hs.window.top(window)
  local frame  = window:frame()
  local screen = window:screen():fullFrame()

  frame.x = screen.x
  frame.y = screen.y
  frame.w = screen.w
  frame.h = screen.h / 2

  window:setFrame(frame)
end

-- Create a window layout mode.
windowLayoutModal = hs.hotkey.modal.new({}, "F16")

-- Bind the given key to call the given function and exit the window layout mode.
function windowLayoutModal.bindWithAutomaticExit(modal, modifiers, key, fn)
  modal:bind(modifiers, key, function()
    modal:exit()
    fn()
  end)
end

-- Load the window bindings.
local _, bindings = pcall(require, "keyboard.windows-bindings")
local modifiers = bindings.modifiers
local trigger   = bindings.trigger

-- Bind the window bindings to the window layout mode and exit after execution.
for index, mapping in ipairs(bindings.mappings) do
  local modifiers, trigger, method = table.unpack(mapping)

  windowLayoutModal:bindWithAutomaticExit(modifiers, trigger, function()
    local focusedWindow = hs.window.focusedWindow()

    focusedWindow[method](focusedWindow)
  end)
end

-- Use modifiers+trigger to toggle the window layout mode.
hs.hotkey.bind(modifiers, trigger, function()
  windowLayoutModal:enter()
end)
windowLayoutModal:bind(modifiers, trigger, function()
  windowLayoutModal:exit()
end)
