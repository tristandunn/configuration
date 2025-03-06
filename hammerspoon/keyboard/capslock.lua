local send_escape = false
local previous_modifiers = {}

-- Count the number entries in a table.
local count = function(table)
  local length = 0

  for _ in pairs(table) do
    length = length + 1
  end

  return length
end

modifier_handler = function(evt)
  local current_modifiers = evt:getFlags()

  if current_modifiers["ctrl"] and count(current_modifiers) == 1 and count(previous_modifiers) == 0 then
    -- If the control key is being held with no other modifiers, mark escape to
    -- be sent.
    send_escape = true
  elseif previous_modifiers["ctrl"] and count(current_modifiers) == 0 and send_escape then
    -- If control key was being held, no modifiers are held, and escape was
    -- marked to be sent then send escape.
    send_escape = false

    hs.eventtap.keyStroke({}, "ESCAPE", 0)
  else
    -- Unmark escape to be sent if any other keys are pressed.
    send_escape = false
  end

  -- Store the previous modifiers for comparison.
  previous_modifiers = current_modifiers

  -- Propagate the key press.
  return false
end

-- Call the modifier handler when a modifier key is pressed or released.
modifier_tap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, modifier_handler)
modifier_tap:start()

-- If any non-modifier key is pressed, unmark escape to be sent.
non_modifier_tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function()
  send_escape = false
  return false
end)
non_modifier_tap:start()
