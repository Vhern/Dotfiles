---- Required libraries ----
awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

gears         = require("gears")
awful         = require("awful")
                require("awful.autofocus")
wibox         = require("wibox")
beautiful     = require("beautiful")
naughty       = require("naughty")
lain          = require("lain")
freedesktop   = require("freedesktop")
hotkeys_popup = require("awful.hotkeys_popup").widget
                require("awful.hotkeys_popup.keys")
my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
dpi           = require("beautiful.xresources").apply_dpi


---- Initial Variables ----

local themes = {
    "cyberpunk",           -- 1
}

modkey        = "Mod4"
altkey        = "Mod1"
chosen_theme  = themes[1]
terminal      = "alacritty"
vi_focus      = false -- vi-like client focus - https://github.com/lcpz/awesome-copycats/issues/275
editor        = os.getenv("EDITOR") or "vim"
gui_editor    = os.getenv("GUI_EDITOR") or "code"
browser       = os.getenv("BROWSER") or "google-chrome-stable"
mini_browser  = " "
calculator    = os.getenv("CALCULATOR") or "qalculate-gtk"
file_explorer = os.getenv("FILE_EXPLORER") or "nemo"
gui_sudo      = "kdesu"
run           = "rofi"

---- Custom Software ----

AndroidStudio = "/usr/local/android-studio/bin/studio.sh"
UnigineHeaven = "home/vhern/Downloads/Unigine_Heaven-4.0/heaven"
Blender = "/home/vhern/Downloads/blender-2.82a-linux64/blender"
TS = "/home/vhern/Downloads/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh"

---- Init ----

theme_path = "~/.config/awesome/themes/" .. chosen_theme .. "/theme.lua"
beautiful.init(theme_path)

awful.util.terminal = terminal
awful.util.tagnames = { "1", "2", "3", "4", "5" }
awful.layout.layouts = awful.layout.suit.corner.ne

require("scr.run_once") -- It could be faster if checking if apps are open before oppening
--require("scr.menu") -- Laggy, too much time to start... find alternative
require("scr.buttons")
require("scr.key_bindings")
require("scr.client_rules")
require("scr.signals_events")

awful.screen.connect_for_each_screen(function(screen) 

    s = screen -- Add public variable for rcr to work properly

    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    require("scr.bar")
    require("scr.wallpaper")

end)
