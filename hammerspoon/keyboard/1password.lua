function onApplicationEvent(name, event, application)
  -- Ignore applications that aren't 1Password.
  if name ~= "1Password 7" then
    return
  end

  if event == hs.application.watcher.launched then
    -- Start watching 1Password when launched.
    watchApplication(application)
  elseif event == hs.application.watcher.terminated then
    -- Stop watching 1Password when terminated.
    if applicationWatcher then
      applicationWatcher:stop()
      applicationWatcher = nil
    end
  end
end

function watchApplication(application, initializing)
  -- Create a watcher for the 1Password application.
  applicationWatcher = application:newWatcher(function(window)
    -- Move the window to the center of the screen.
    hs.window.center(window)
  end)

  -- Start watching for windows being created.
  applicationWatcher:start({hs.uielement.watcher.windowCreated})
end

-- Create an application watcher to watch for 1Password launching.
local applicationWatcher  = nil
local applicationsWatcher = hs.application.watcher.new(onApplicationEvent)

-- Start watching all applications.
applicationsWatcher:start()

hs.application.enableSpotlightForNameSearches(true)

-- Attempt to find running 1Password application.
local application = hs.appfinder.appFromName("1Password 7")

-- Watch the application if found.
if application then
  watchApplication(application)
end
