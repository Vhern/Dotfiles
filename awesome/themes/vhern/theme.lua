--[[

     Vhern Awesome WM theme
     https://github.com/Vhern/LinuxConfig.git

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/vhern"
theme.wallpaper                                 = theme.dir .. "/wall.jpg"
theme.font                                      = "Terminus 9"

-------------------------------------------------------------------
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#CE42EB" -- Primary Color (Violet)
theme.fg_urgent                                 = "#C83F11"

theme.bg_normal                                 = "#222222"
theme.bg_focus                                  = "#303030"
theme.bg_urgent                                 = "#3F3F3F"
-------------------------------------------------------------------
-------------------------------------------------------------------
theme.taglist_fg_normal                         = theme.fg_normal
theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_fg_urgent                         = theme.fg_urgent

theme.taglist_bg_normal                         = theme.bg_normal
theme.taglist_bg_focus                          = theme.bg_focus
theme.taglist_bg_urgent                         = theme.bg_urgent

theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
-------------------------------------------------------------------
-------------------------------------------------------------------
theme.tasklist_fg_normal                        = theme.fg_normal
theme.tasklist_fg_focus                         = theme.fg_focus
theme.tasklist_fg_urgent                        = theme.fg_urgent

theme.tasklist_bg_normal                        = theme.bg_normal
theme.tasklist_bg_focus                         = theme.bg_focus
theme.tasklist_bg_urgent                        = theme.bg_urgent

theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
-------------------------------------------------------------------
-------------------------------------------------------------------
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.bg_focus
theme.border_focus                              = theme.fg_focus
theme.border_marked                             = "#CC9393"
-------------------------------------------------------------------
-------------------------------------------------------------------
theme.menu_height                               = dpi(24)
theme.menu_width                                = dpi(160)

theme.menu_fg_normal                            = theme.fg_normal
theme.menu_fg_focus                             = theme.fg_focus
theme.menu_fg_urgent                            = theme.fg_urgent

theme.menu_bg_normal                            = theme.bg_normal
theme.menu_bg_focus                             = theme.bg_focus
theme.menu_bg_urgent                            = theme.bg_urgent
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
-------------------------------------------------------------------
-------------------------------------------------------------------
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_brightness                         = theme.dir .. "/icons/brightness.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.widget_clock                              = theme.dir .. "/icons/clock.svg"
theme.widget_weather                            = theme.dir .. "/icons/weather.svg"

theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.useless_gap                               = dpi(5)

-- App specific icons
theme.android_studio                            = theme.dir .. "/icons/app_specifics/android_studio.svg"
theme.unigine_heaven                            = theme.dir .. "/icons/app_specifics/unigine_heaven.png"
theme.blender                                   = theme.dir .. "/icons/app_specifics/blender.svg"

local markup = lain.util.markup
local separators = lain.util.separators

-- Clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    --cal = "cal --color=always",
    attach_to = { clock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
    city_id = 2643743, -- placeholder (London)
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    },
    weather_na_markup = markup.font(theme.font, "N/A"),
    settings = function()
        --descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.font(theme.font, "Havana " .. units .. "°C"))
    end
})

-- RAM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, math.floor((mem_now.used / 1024 * 100)+0.5) / 100 .. "GB (" .. math.floor(((mem_now.used / mem_now.total) * 100)+0.5) .. "%)"))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, cpu_now.usage .. "%"))
    end
})

-- Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, coretemp_now .. "°C"))
    end
})
local tempicon = wibox.widget.imagebox(theme.widget_temp)

-- Storage (It needs Gio/Glib >= 2.54)
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
    settings = function()
        local fsp = string.format(" %3.2f %s", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(theme.font, fsp))
    end
})

-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
           string.match(theme.weather.widget.text, "N/A")
        then
            theme.weather.update()
        end

        widget:set_markup(markup.font(theme.font, net_now.received .. " BK/s ↓↑ " .. net_now.sent .. " BK/s"))
    end
})

-- Separator
local sepparator = separators.arrow_left

function theme.at_screen_connect(s)

    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)
    
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                        awful.button({}, 1, function () awful.layout.inc( 1) end),
                        awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                        awful.button({}, 3, function () awful.layout.inc(-1) end),
                        awful.button({}, 4, function () awful.layout.inc( 1) end),
                        awful.button({}, 5, function () awful.layout.inc(-1) end)))
                        
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { bg_focus = theme.bg_focus, shape = gears.shape.rectangle, align = "center" })
    
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(25), bg = theme.bg_normal, fg = theme.fg_normal })

    -- widgets background color
    local color = 
    {
        theme.bg_normal,
        "#444444", -- Grey
        "#4b6d51", -- Old Green
        "#595f78", -- Old Blue
        "#75615a", -- Brown
        "#544759", -- Old Violet
        "#5c7a79", -- Old Blue
        "#CB755B", -- Orange
        "#9c9c83", -- Old Yellow
        "#4B696D", -- blue??
        "#4B3B51", -- violet??
        "#8DAA9A", -- cyan??
        "#C0C0A2", -- yellow??
    }

    local lastWidgetItter = 2 -- Starts on first non default color

    local function AddSepparator()
        return sepparator(color[lastWidgetItter - 1], color[lastWidgetItter])
    end
    
    local function AddWidged(widget, color)  

        lastWidgetItter = lastWidgetItter + 1
        AddSepparator()
        
        return wibox.container.background(wibox.container.margin(widget, 0, dpi(4)), color)

    end

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),

            AddSepparator(),
            AddWidged(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { fsicon, theme.fs and theme.fs.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { nil, weathericon, theme.weather.widget, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            AddSepparator(),
            AddWidged(wibox.widget { nil, clockicon, clock, layout = wibox.layout.align.horizontal }, color[lastWidgetItter]),

            --AddSepparator(),
            --AddWidged(s.mylayoutbox, color[lastWidgetItter]),
        },
    }
end

return theme
