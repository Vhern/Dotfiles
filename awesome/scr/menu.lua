local myAwesomeMenu = {
   { "Open Terminal", terminal },
   { "Hotkeys", function() return false, hotkeys_popup.show_help end },
   { "Manual", terminal .. " -e man awesome" },
   { "Edit Config", terminal .. " -e " .. gui_editor .. " " .. awesome.conffile },
   { "Edit Theme", terminal .. " -e " .. gui_editor .. " " --[[.. theme_path ]]},
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end }
}

local myCustomMenu = {
   { "Android Studio", AndroidStudio, beautiful.android_studio },
   { "Unigine Heaven", UnigineHeaven, beautiful.unigine_heaven },
   { "Blender", Blender, beautiful.blender },
   { "Team Speak", TS, beautiful.blender },
   { "Dukto", "dukto", beautiful.blender },
   { "Prime95", "mprime", beautiful.blender },
   { "Unigine Heaven", "unigine-heaven", beautiful.blender },
}

awful.util.mymainmenu = freedesktop.menu.build({
   icon_size = beautiful.menu_height or dpi(16),
   before = {
       { "Awesome", myAwesomeMenu, beautiful.awesome_icon },
       -- other triads can be put here
   },
   after = {
       { "Others", myCustomMenu, beautiful.awesome_icon },
       -- other triads can be put here
   }
})

-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

-- hide menu when key is pressed
awful.util.mymainmenu.wibox:connect_signal("button::press", function() awful.util.mymainmenu:hide() end)
