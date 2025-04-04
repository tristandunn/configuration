local safariWatcher = nil

local function onApplicationEvent(name, event, application)
  -- Ignore applications that aren't Safari.
  if name ~= "Safari" then
    return
  end

  if event == hs.application.watcher.launched then
    -- Start watching Safari when launched.
    WatchApplication(application)
  elseif event == hs.application.watcher.terminated then
    -- Stop watching Safari when terminated.
    if safariWatcher then
      safariWatcher:stop()
      safariWatcher = nil
    end
  end
end

function WatchApplication(application)
  -- Create a watcher for the Safari application.
  safariWatcher = application:newWatcher(function(window)
    -- Sometimes window appears to be missing.
    if not window or not window["title"] then
      return
    end

    local title = window:title()

    -- Only reposition browser windows.
    if string.match(title, "Untitled") then
      local width = hs.screen.primaryScreen():fullFrame().w
      local laptop = width == 1470.0 or width == 1728.0

      if laptop then
        -- Move the window to the full screen size.
        hs.window.fullscreen(window)
      else
        -- Move the window to the default size and position.
        hs.window.default(window)
      end
    end
  end)

  -- Start watching for windows being created.
  safariWatcher:start({ hs.uielement.watcher.windowCreated })
end

-- Create an application watcher to watch for Safari launching.
local applicationsWatcherForSafari = hs.application.watcher.new(onApplicationEvent)

-- Start watching all applications.
applicationsWatcherForSafari:start()

-- Attempt to find running Safari application.
local application = hs.appfinder.appFromName("Safari")

-- Watch the application if found.
if application then
  WatchApplication(application)
end
