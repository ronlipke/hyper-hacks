
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- The following keys are configured as hot keys in their respective apps (or in Keyboard Maestro)
-- d → Dash (configure in Dash preferences)
-- h → HazeOver (configure in HazeOver preferences)
-- m → Alfred -> migraines (can also set with function)i
-- n → Notifications configure in System preferences → Keyboard → Shortcuts → Mission Control)
-- f → Fantastical (configure in Fantastical preferences)
-- t → Typinator (configure in Typinator preferences)
-- SPACE → Spotlight (configure in System Preferences → Keyboard → Shortcuts → Spotlight, moved so that ⌘␣ could be used for Quicksilver)
hyperBindings = {'d','h','m','n','f','t','SPACE'}

for i,key in ipairs(hyperBindings) do
  k:bind({}, key, nil, function() hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
    k.triggered = true
  end)
end

-- -- HYPER+L: Open news.google.com in the default browser
-- lfun = function()
--   news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
--   hs.osascript.javascript(news)
--   k.triggered = true
-- end
-- k:bind('', 'l', nil, lfun)

-- HYPER+M: Call a pre-defined trigger in Alfred 3
-- mfun = function()
--   cmd = "tell application \"Alfred 3\" to run trigger \"emoj\" in workflow \"com.sindresorhus.emoj\" with argument \"\""
--   hs.osascript.applescript(cmd)
--   k.triggered = true
-- end
-- k:bind({}, 'm', nil, mfun)

-- -- HYPER+E: Act like ⌃e and move to end of line.
-- efun = function()
--   hs.eventtap.keyStroke({'⌃'}, 'e')
--   k.triggered = true
-- end
-- k:bind({}, 'e', nil, efun)

-- -- HYPER+A: Act like ⌃a and move to beginning of line.
-- afun = function()
--   hs.eventtap.keyStroke({'⌃'}, 'a')
--   k.triggered = true
-- end
-- k:bind({}, 'a', nil, afun)

-- -- Single keybinding for app launch
-- singleapps = {
--   {'q', 'MailMate'},
--   {'w', 'OmniFocus'},
--   {'e', 'Sublime Text'},
--   {'r', 'Google Chrome'}
-- }

-- for i, app in ipairs(singleapps) do
--   k:bind({}, app[1], function() launch(app[2]); k:exit(); end)
-- end

-- -- Sequential keybindings, e.g. Hyper-a,f for Finder
-- a = hs.hotkey.modal.new({}, "F16")
-- apps = {
--   {'d', 'Twitter'},
--   {'f', 'Finder'},
--   {'s', 'Skype'},
-- }
-- for i, app in ipairs(apps) do
--   a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
-- end

-- pressedA = function() a:enter() end
-- releasedA = function() end
-- k:bind({}, 'a', nil, pressedA, releasedA)

ofun = function()
  hs.reload()
  hs.alert.show("Config loaded")
  k.triggered = true
end
k:bind({}, 'o', nil, ofun)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)
