local applications      = {}
local chooser           = nil
local fzy               = loadfile(hs.spoons.scriptPath() .. "fzy/fzy.lua")()
local hotkey            = nil
local queryChangedTimer = nil
local spotlight         = nil

-- Create a table lookup of application names to disallow.
local disallow = {
  ["1Password for Safari"] = true,
  ["AirPort Utility"] = true,
  ["Audio MIDI Setup"] = true,
  ["Automator"] = true,
  ["Bluetooth File Exchange"] = true,
  ["Books"] = true,
  ["Boot Camp Assistant"] = true,
  ["Chess"] = true,
  ["Class Progress Preferences"] = true,
  ["Classroom Preferences"] = true,
  ["ColorSync Utility"] = true,
  ["Console"] = true,
  ["Disk Utility"] = true,
  ["Font Book"] = true,
  ["Grapher"] = true,
  ["Launchpad"] = true,
  ["Mail"] = true,
  ["Migration Assistant"] = true,
  ["News"] = true,
  ["Podcasts"] = true,
  ["Script Editor"] = true,
  ["Stickies"] = true,
  ["Stocks"] = true,
  ["System Information"] = true,
  ["Time Machine"] = true,
  ["Voice Memos"] = true,
  ["VoiceOver Utility"] = true
}

-- Create a table lookup of applications to rename.
local rename = {
  ["kitty"] = "Kitty"
}

-- Create a table of custom actions to include.
local actions = {
  ["Search"] = {
    keyword = "ddg",
    root    = "https://duckduckgo.com",
    subText = "Search DuckDuckGo${query}.",
    type    = "url",
    url     = "https://duckduckgo.com/?q=${query}"
  },
  ["GitHub"] = {
    keyword = "gh",
    root    = "https://github.com",
    subText = "Search GitHub${query}.",
    type    = "url",
    url     = "https://github.com/search?q=${query}"
  }
}

-- Modify the applications table by adding, updating, or removing an application.
local modifyApplicationsTable = function(info, add)
  for _, item in ipairs(info) do
    local icon = nil
    local name = item.kMDItemDisplayName or hs.fs.displayName(item.kMDItemPath)

    -- Clean up the name.
    name = name:gsub("%.app$", "", 1)
    name = name:gsub(".prefPane", "", 1)

    -- Adjust name for preference panes.
    if string.find(item.kMDItemPath, "%.prefPane$") then
      name = name .. " Preferences"
    end

    -- Skip disallowed application names.
    if disallow[name] then
    else
      -- When adding a preference pane, extract the icon from the file.
      if add and string.find(item.kMDItemPath, "%.prefPane$") then
        icon = hs.image.iconForFile(item.kMDItemPath)
      end

      if add then
        bundleID = item.kMDItemCFBundleIdentifier

        -- If no icon is specified for a bundle, extract it from the bundle.
        if (not icon) and bundleID then
          icon = hs.image.imageFromAppBundle(bundleID)
        end

        -- Add or update the application by name.
        applications[name] = {
          bundleID = bundleID,
          icon     = icon,
          path     = item.kMDItemPath
        }
      else
        -- Remove the application.
        applications[name] = nil
      end
    end
  end

  chooser:refreshChoicesCallback()
end

-- Callback to generate a list of choices based by fuzzy searching with the
-- chooser query.
local onChoicesCallback = function()
  query   = tostring(chooser:query()):lower()
  choices = {}

  -- Ignore a blank query.
  if query:find("^%s*$") ~= nil then
    return choices
  end

  -- Add applications that match the query.
  for name,application in pairs(applications) do
    if string.match(name:lower(), query) then
      local choice = {
        path = application["path"],
        text = rename[name] or name,
        type = "application"
      }

      if application["icon"] then
        choice["image"] = application["icon"]
      end

      table.insert(choices, choice)
    end
  end

  -- Add actions that match the query.
  for name,action in pairs(actions) do
    if action["keyword"] then
      if string.find(query, "^" .. action["keyword"]:lower()) then
        local subText = action["subText"]
        local keyword, rawQuery = string.match(query, "([^%s]+)%s+(.*)")

        if rawQuery and rawQuery ~= "" then
          subText = subText:gsub("${query}", " for \"" .. rawQuery .. "\"")
        else
          subText = subText:gsub("${query}", "")
        end

        table.insert(choices, {
          query   = query,
          root    = action["root"],
          subText = subText,
          text    = name,
          type    = action["type"],
          url     = action["url"]
        })
      end
    end
  end

  -- Remove commas and dollar signs.
  query, _ = query:gsub("[%,%$]", "")
  -- Remove trailing operators.
  query, _ = query:gsub("[%+%-%*%/]$", "")

  -- Add calculation if the query matches.
  if string.match(query, "[^%d^%.^%+^%-^/^%*^%^^ ^%(^%)]") == nil then
    local compile, _ = load("return " .. query)

    if type(compile) == "function" then
      local result = compile()
      local _, _, negative, integer, fraction = tostring(result):find('([-]?)(%d+)([.]?%d*)')

      integer = integer:reverse():gsub("(%d%d%d)", "%1,")
      result  = negative .. integer:reverse():gsub("^,", "") .. fraction

      table.insert(choices, {
        image   = hs.image.imageFromAppBundle("com.apple.Calculator"),
        subText = "Copy to Clipboard",
        text    = result,
        type    = "copyToClipboard"
      })
    end
  end


  -- Sort the choices with fuzzy string matching.
  table.sort(choices, function(a, b)
    return fzy.score(query, a.text) > fzy.score(query, b.text)
  end)

  return choices
end

-- Callback to act on the selected row, if any.
local onCompletionCallback = function(row)
  -- Clear the query and update the choices after a selection has been made.
  chooser:query(nil)
  chooser:refreshChoicesCallback()

  -- Ignore the callback if no row was selected.
  if row == nil then
    return
  end

  -- Open application by path.
  if row["type"] == "application" then
    hs.task.new("/usr/bin/open", nil, { row["path"] }):start()
  end

  -- Copy text to the clipboard.
  if row["type"] == "copyToClipboard" then
    hs.pasteboard.setContents(row["text"])
  end

  -- Open a URL, replacing query placeholder if present.
  if row["type"] == "url" then
    local url = row.root
    local keyword, query = string.match(row.query, "([^%s]+)%s+(.*)")

    if query and query ~= "" then
      url = row.url:gsub("${query}", query)
    end

    if url then
      hs.execute(string.format("/usr/bin/open '%s'", url))
    end
  end
end

-- Callback to refresh the choices after the query is changed.
local onQueryChangedCallback = function(query)
  if queryChangedTimer then
    queryChangedTimer:stop()
  end

  queryChangedTimer = hs.timer.doAfter(0.05, function()
    chooser:refreshChoicesCallback()
  end)
end

-- Callback for when Spotlight adds, updates, or changes items.
local onUpdateApplications = function(object, message, info)
  if info then
    if info.kMDQueryUpdateAddedItems then
      modifyApplicationsTable(info.kMDQueryUpdateAddedItems, true)
    end

    if info.kMDQueryUpdateChangedItems then
      modifyApplicationsTable(info.kMDQueryUpdateChangedItems, true)
    end

    if info.kMDQueryUpdateRemovedItems then
      modifyApplicationsTable(info.kMDQueryUpdateRemovedItems, false)
    end
  end
end

-- Toggle the chooser visibility.
local toggle = function()
  if chooser:isVisible() then
    chooser:hide()
  else
    chooser:show()
  end
end

-- Create the chooser with callbacks and customization.
chooser = hs.chooser.new(onCompletionCallback)
chooser:choices(onChoicesCallback)
chooser:queryChangedCallback(onQueryChangedCallback)
chooser:rows(9)

-- Start the Spotlight search with a callback.
spotlight = hs.spotlight.new():queryString([[ (kMDItemContentType = "com.apple.application-bundle") || (kMDItemContentType = "com.apple.systempreference.prefpane") || (kMDItemContentType = "com.apple.applescript.text") ]])
  :callbackMessages("didUpdate", "inProgress")
  :setCallback(onUpdateApplications)
  :searchScopes({
    "/Applications",
    "/System/Applications",
    "~/Applications",
    "/System/Library/PreferencePanes"
  })
  :start()

-- Create and enable the hotkey for toggling the chooser.
hotkey = hs.hotkey.new({"cmd"}, "space", toggle)
hotkey:enable()
