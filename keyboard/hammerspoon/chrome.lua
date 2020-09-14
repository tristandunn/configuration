function onApplicationEvent(name, event, application)
  -- Ignore applications that aren't Chrome.
  if name ~= "Google Chrome" then
    return
  end

  if event == hs.application.watcher.launched then
    -- Start watching Chrome when launched.
    watchChrome(application)
  elseif event == hs.application.watcher.terminated then
    -- Stop watching Chrome when terminated.
    if chromeWatcher then
      chromeWatcher:stop()
      chromeWatcher = nil
    end
  end
end

function watchChrome(application, initializing)
  -- Create a watcher for the Chrome application.
  chromeWatcher = application:newWatcher(function(window)
    -- Only reposition browser windows.
    if string.match(window:title(), "New Tab") then
      -- Move the window to the default size and position.
      hs.window.default(window)
    end
  end)

  -- Start watching for windows being created.
  chromeWatcher:start({hs.uielement.watcher.windowCreated})
end

-- Create an application watcher to watch for Chrome launching.
local applicationWatcher = hs.application.watcher.new(onApplicationEvent)
local chromeWatcher      = nil

-- Start watching all applications.
applicationWatcher:start()

-- Attempt to find running Chrome application.
local chrome = hs.appfinder.appFromName("Google Chrome")

-- Watch the application if found.
if chrome then
  watchChrome(chrome)
end
