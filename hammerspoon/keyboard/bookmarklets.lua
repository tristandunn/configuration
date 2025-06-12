local bindings = {
  modifiers = { "ctrl" },
  trigger   = "b",
  mappings  = {
    { {}, "a", "alert" },
    { {}, "t", "title" },
    { {}, "u", "url" },
    { {}, "w", "wayback" }
  }
}

local bookmarklets = {
  alert   = "alert(1)",
  title   = "alert(document.title)",
  url     = "alert(window.location.toString())",
  wayback = [[window.open('https://web.archive.org/web/*/'+location.href)]]
}

-- Create a window layout mode.
local windowLayoutModal = hs.hotkey.modal.new({}, "F17")

-- Bind the given key to call the given function and exit the window layout mode.
function windowLayoutModal.bindWithAutomaticExit(modal, modifiers, key, fn)
  modal:bind(modifiers, key, nil, function()
    modal:exit()
    fn()
  end)
end

-- Bind the window bindings to the window layout mode and exit after execution.
for _, mapping in ipairs(bindings.mappings) do
  local modifiers, trigger, method = table.unpack(mapping)

  windowLayoutModal:bindWithAutomaticExit(modifiers, trigger, function()
    local code = bookmarklets[method]

    hs.osascript.applescript([[
      tell application "Safari"
        activate
        do JavaScript "]] .. code .. [[" in current tab of first window
      end tell
    ]])
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
