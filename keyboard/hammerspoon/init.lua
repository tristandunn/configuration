-- Load the customization scripts.
require("keyboard.1password")
require("keyboard.capslock")
require("keyboard.chrome")
require("keyboard.windows")

-- Bind Control+` to reload the Hammerspoon configuration.
hs.hotkey.bind({"ctrl"}, "`", nil, function()
  hs.reload()
end)
