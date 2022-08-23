-- Widgets Declaration
require("scr.widgets")

local sepparator = lain.util.separators.arrow_left

-- Create the wibox
s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(25),
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
})




                    
-- Create a taglist widget
s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

-- Create a tasklist widget
s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.minimizedcurrenttags,
    buttons  = awful.util.tasklist_buttons,
    layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 24,
                thickness     = 1,
                color         = '#777777',
                widget        = wibox.widget.separator
            },
            align = 'center',
            widget = wibox.container.place,
        },
        spacing = 10,
        layout  = wibox.layout.fixed.horizontal
    },
    widget_template = {
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            margins = 2,
            layout = wibox.layout.fixed.horizontal,
        },
        nil,
        create_callback = function(self, c, index, clients)

            awful.tooltip {
                objects         = { self },
                timer_function  = function()
                    return c.name
                end
            }

            self:get_children_by_id('clienticon')[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
}

-- Show also focused client
s.focusedclient = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.focused,
    buttons  = awful.util.tasklist_buttons,
    widget_template = {
        {
            {
                id     = 'clienticon',
                widget = awful.widget.clienticon,
            },
            {
                id     = 'text_role',
                widget = wibox.widget.textbox,
            },
            layout  = wibox.layout.fixed.horizontal,
        },
        create_callback = function(self, c, index, clients)
            self:get_children_by_id('clienticon')[1].client = c
        end,
        layout = wibox.layout.align.vertical,
    },
}

-- widgets background color
local pastelColor = 
{
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

local cyberColors =
{
    "#444444", -- Grey
    "#678cd5", -- Blue
    "#8b6ba9"  -- Purple
}

local lastWidgetItter = 1

local function GetColor(itter)
    local cyber = true

    if cyber then
        return cyberColors[(itter % 2) + 2]
    end

    return pastelColor[itter]
end

local firstSeparator = true
local function AddSepparator()
    if firstSeparator then
        firstSeparator = false
        return sepparator(beautiful.bg_normal, GetColor(lastWidgetItter))
    end
    
    return sepparator(GetColor(lastWidgetItter - 1), GetColor(lastWidgetItter))
end

local firstWidged = true
local function AddWidged(widget, color)  

    lastWidgetItter = lastWidgetItter + 1

    if firstWidged == true then -- First widged is SysTray Widged
        firstWidged = false
        beautiful.systray_icon_spacing = dpi(6)
        beautiful.bg_systray = color
    end
    
    return wibox.container.background(wibox.container.margin(widget, 0, dpi(4)), color)

end

-- Add widgets to the wibox
s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        
    },
    {-- Middle widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytasklist, 
    },
    { -- Right widgets
        s.focusedclient,

        layout = wibox.layout.fixed.horizontal,

        AddSepparator(),
        AddWidged(wibox.widget { wibox.widget.systray(), layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { mem_icon, mem_widget.widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { cpu_icon, cpu_widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { temp_icon, temp.widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { fs_icon, beautiful.fs and beautiful.fs.widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { nte_icon, beautiful.net, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { volumebar_widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { weather_icon, beautiful.weather, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { clock_icon, clock, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),

        AddSepparator(),
        AddWidged(wibox.widget { logout_widget, layout = wibox.layout.align.horizontal }, GetColor(lastWidgetItter)),
    },
}