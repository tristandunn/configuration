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

function watchApplication(application, initializing)
  -- Create a watcher for the Chrome application.
  applicationWatcher = application:newWatcher(function(window)
    -- Only reposition browser windows.
    if string.match(window:title(), "New Tab") or string.match(window:title(), "Untitled") then
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
