local markup = lain.util.markup
local separators = lain.util.separators

-- RAM
mem_icon = wibox.widget.imagebox(beautiful.widget_mem)
mem_widget = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, math.floor((mem_now.used / 1024 * 100)+0.5) / 100 .. "GB (" .. math.floor(((mem_now.used / mem_now.total) * 100)+0.5) .. "%)"))
    end
})

-- CPU
cpu_icon = wibox.widget.imagebox(beautiful.widget_cpu)
cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")({
    --[[
        | Name | Default | Description |
        |---|---|---|
        | `width` | 50 | Width of the widget |
        | `step_width` | 2 | Width of the step |
        | `step_spacing` | 1 | Space size between steps |
        | `color` | `beautiful.fg_normal` | Color of the graph |
        | `enable_kill_button` | `false` | Show button which kills the process |
        | `process_info_max_length` | `-1` | Truncate the process information. Some processes may have a very long list of parameters which won't fit in the screen, this options allows to truncate it to the given length. |
        | `timeout` | 1 | How often in seconds the widget refreshes |
    ]]

    width = 40,
    step_width = 2,
    step_spacing = 0,
    color = beautiful.fg_normal,
    enable_kill_button = true
})


-- Coretemp (lain, average)
temp_icon = wibox.widget.imagebox(beautiful.widget_temp)
temp = awful.widget.watch('bash -c "cat /sys/class/hwmon/hwmon0/device/temp1_input"', 15,
function(widget, s) widget:set_text(("%d°C"):format(tonumber(s)/1000)) end)

-- Storage (It needs Gio/Glib >= 2.54)
fs_icon = wibox.widget.imagebox(beautiful.widget_hdd)
beautiful.fs = lain.widget.fs({
    notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = "Terminus 10" },
    settings = function()
        local fsp = string.format(" %3.2f %s", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(beautiful.font, fsp))
    end
})

-- Volume bar



-- Weather
weather_icon = wibox.widget.imagebox(beautiful.widget_weather)
beautiful.weather = lain.widget.weather({
    city_id = 3553478, -- Habana
    settings = function()
        --descr = weather_now["weather"][1]["description"]:lower()
        units = weather_now["main"]["temp"]
        widget:set_markup(markup.font(beautiful.font, "Habana " .. units .. "°C"))
    end
})

-- Net
nte_icon = wibox.widget.imagebox(beautiful.widget_net)
beautiful.net = lain.widget.net({
    settings = function()
        if iface ~= "network off" and
            string.match(beautiful.weather.widget.text, "N/A")
        then
            beautiful.weather.update()
        end

        widget:set_markup(markup.font(beautiful.font, net_now.received .. " BK/s ↓↑ " .. net_now.sent .. " BK/s"))
    end
})

-- Clock
clock_icon = wibox.widget.imagebox(beautiful.widget_clock)
clock = awful.widget.watch(
    "date +'%a %d %b %R'", 60,
    function(widget, stdout)
        widget:set_markup(markup.font(beautiful.font, stdout))
    end
)

-- Calendar
beautiful.cal = lain.widget.cal({
    --cal = "cal --color=always",
    attach_to = { clock },
    notification_preset = {
        font = beautiful.font,
        fg   = beautiful.fg_normal,
        bg   = beautiful.bg_normal
    }
})

-- Logout Menu
logout_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")({
    --[[
        | Name | Default | Description |
        |---|---|---|
        | `font` | `beautiful.font` | Font of the menu items |
        | `onlogout` | `function() awesome.quit() end` | Function which is called when the logout item is clicked |
        | `onlock` | `function() awful.spawn.with_shell("i3lock") end` | Function which is called when the lock item is clicked |
        | `onreboot` | `function() awful.spawn.with_shell("reboot") end` | Function which is called when the reboot item is clicked |
        | `onsuspend` | `function() awful.spawn.with_shell("systemctl suspend") end` | Function which is called when the suspend item is clicked |
        | `onpoweroff` | `function() awful.spawn.with_shell("shutdown now") end` | Function which is called when the poweroff item is clicked |
    ]]
})