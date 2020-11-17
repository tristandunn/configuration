local chromeWatcher = nil

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
    if chromeWatcher then
      chromeWatcher:stop()
      chromeWatcher = nil
    end
  end
end

function watchApplication(application)
  -- Create a watcher for the Chrome application.
  chromeWatcher = application:newWatcher(function(window)
    -- Sometimes window appears to be missing.
    if not window then
      return
    end

    local title = window:title()

    -- Only reposition browser windows.
    if string.match(title, "New Tab") or string.match(title, "Untitled") then
      -- Move the window to the default size and position.
      hs.window.default(window)
    end
  end)

  -- Start watching for windows being created.
  chromeWatcher:start({hs.uielement.watcher.windowCreated})
end

-- Create an application watcher to watch for Chrome launching.
applicationsWatcherForChrome = hs.application.watcher.new(onApplicationEvent)

-- Start watching all applications.
applicationsWatcherForChrome:start()

-- Attempt to find running Chrome application.
local application = hs.appfinder.appFromName("Google Chrome")

-- Watch the application if found.
if application then
  watchApplication(application)
end
