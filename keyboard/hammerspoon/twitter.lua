local twitterWatcher = nil

function onApplicationEvent(name, event, application)
  -- Ignore applications that aren't Twitter.
  if name ~= "Twitter" then
    return
  end

  if event == hs.application.watcher.launched then
    -- Start watching Twitter when launched.
    watchApplication(application)
  elseif event == hs.application.watcher.terminated then
    -- Stop watching Twitter when terminated.
    if twitterWatcher then
      twitterWatcher:stop()
      twitterWatcher = nil
    end
  end
end

function watchApplication(application)
  -- Create a watcher for the Twitter application.
  twitterWatcher = application:newWatcher(function(window)
    -- Sometimes window appears to be missing.
    if not window then
      return
    end

    local title = window:title()

    -- Only reposition the main window.
    if string.match(title, "Twitter") then
      local frame  = window:frame()
      local screen = window:screen():fullFrame()

      frame.w = 640
      frame.h = (screen.h / 10) * 8
      frame.x = (screen.w / 2) - (frame.w / 2)
      frame.y = (screen.h / 2) - (frame.h / 2)

      -- Move the window to the custom size and position.
      window:setFrame(frame)
    else
      hs.window.center(window)
    end
  end)

  -- Start watching for windows being created.
  twitterWatcher:start({hs.uielement.watcher.windowCreated})
end

-- Create an application watcher to watch for Twitter launching.
applicationsWatcherForTwitter = hs.application.watcher.new(onApplicationEvent)

-- Start watching all applications.
applicationsWatcherForTwitter:start()

-- Attempt to find running Twitter application.
local application = hs.appfinder.appFromName("Twitter")

-- Watch the application if found.
if application then
  watchApplication(application)
end
