-- Load the customization scripts.
require("keyboard.capslock")
require("keyboard.safari")
require("keyboard.windows")

-- Bind Control+` to reload the Hammerspoon configuration.
hs.hotkey.bind({ "ctrl" }, "`", nil, function()
  hs.reload()
end)
