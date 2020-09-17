function onApplicationEvent(name, event, application)
  -- Ignore applications that aren't Chrome.
  if name ~= "Google Chrome" then
    return
  end

  if event == hs.application.watcher.launched then
    -- Start watching Chrome when launched.
    watchApplication(application)
  elseif event == hs.application.watcher.terminated then
    -- Stop watching Chrome when terminated.
    if applicationWatcher then
      applicationWatcher:stop()
      applicationWatcher = nil
    end
  end
end

function watchApplication(application)
  -- Create a watcher for the Chrome application.
  applicationWatcher = application:newWatcher(function(window)
    -- Sometimes window appears to be nil, but not sure why.
    if window == nil then
      return
    end

    local title = window:title()

    -- Only reposition browser windows.
    if title and string.match(title, "New Tab") or string.match(title, "Untitled") then
      -- Move the window to the default size and position.
      hs.window.default(window)
    end
  end)

  -- Start watching for windows being created.
  applicationWatcher:start({hs.uielement.watcher.windowCreated})
end

-- Create an application watcher to watch for Chrome launching.
local applicationWatcher  = nil
local applicationsWatcher = hs.application.watcher.new(onApplicationEvent)

-- Start watching all applications.
applicationsWatcher:start()

-- Attempt to find running Chrome application.
local application = hs.appfinder.appFromName("Google Chrome")

-- Watch the application if found.
if application then
  watchApplication(application)
end
