-- Mouse bindings
root.buttons(my_table.join(
   awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
))

-- Key bindings
globalkeys = my_table.join(

   -- Awesome Hotkeys
   awful.key({ modkey, "Control" }, "r", awesome.restart,
       {description = "reload awesome", group = "Awesome"}),
   awful.key({ modkey, "Control" }, "q", awesome.quit,
       {description = "quit awesome", group = "Awesome"}),
   awful.key({ modkey }, "s", hotkeys_popup.show_help,
       {description = "show help", group = "Awesome"}),

   awful.key({ modkey, "Control" }, "c", function () os.execute(terminal .. " -e " .. file_explorer .. " " .. "~/.config/awesome") end,
       {description = "Edit Config", group = "Awesome"}),

   -- User programs
   awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
       {description = "open a terminal", group = "Launcher"}),
   awful.key({ modkey }, "b", function () awful.spawn(browser) end,
       {description = "run browser", group = "Launcher"}),
   awful.key({ modkey }, "g", function () awful.spawn(mini_browser) end,
       {description = "run mini browser", group = "Launcher"}),
   awful.key({ modkey }, "v", function () awful.spawn(gui_editor) end,
       {description = "run gui editor", group = "Launcher"}),
   awful.key({ modkey }, "c", function () awful.spawn(calculator) end,
       {description = "run calculator", group = "Launcher"}),
   awful.key({ modkey }, "e", function () awful.spawn(file_explorer) end,
       {description = "run file explorer", group = "Launcher"}),
   awful.key({ modkey }, "t", function () awful.spawn(TS) end,
       {description = "run team speak", group = "Launcher"}),

   -- Rofi run
   awful.key({ modkey }, "space", function () os.execute(run .. " -show run") end,
       {description = "show dmenu", group = "Launcher"}),

   -- Rofi window
   awful.key({ altkey }, "Tab", function () os.execute(run .. " -show window") end,
       {description = "show rofi", group = "Launcher"}),

   -- By direction client focus
   awful.key({ modkey }, "Down",
       function()
           awful.client.focus.global_bydirection("down")
           if client.focus then client.focus:raise() end
       end,
       {description = "focus down", group = "Client"}),
   awful.key({ modkey }, "Up",
       function()
           awful.client.focus.global_bydirection("up")
           if client.focus then client.focus:raise() end
       end,
       {description = "focus up", group = "Client"}),
   awful.key({ modkey }, "Left",
       function()
           awful.client.focus.global_bydirection("left")
           if client.focus then client.focus:raise() end
       end,
       {description = "focus left", group = "Client"}),
   awful.key({ modkey }, "Right",
       function()
           awful.client.focus.global_bydirection("right")
           if client.focus then client.focus:raise() end
       end,
       {description = "focus right", group = "Client"}),

   -- By direction client swap
   awful.key({ modkey, "Control" }, "Down",
       function()
           awful.client.swap.global_bydirection("down")
           if client.swap then client.swap:raise() end
       end,
       {description = "swap down", group = "Client"}),
   awful.key({ modkey, "Control" }, "Up",
       function()
           awful.client.swap.global_bydirection("up")
           if client.swap then client.swap:raise() end
       end,
       {description = "swap up", group = "Client"}),
   awful.key({ modkey, "Control" }, "Left",
       function()
           awful.client.swap.global_bydirection("left")
           if client.swap then client.swap:raise() end
       end,
       {description = "swap left", group = "Client"}),
   awful.key({ modkey, "Control" }, "Right",
       function()
           awful.client.swap.global_bydirection("right")
           if client.swap then client.swap:raise() end
       end,
       {description = "swap right", group = "Client"}),

   -- Size Mod
   awful.key({ modkey, altkey }, "Up",     function () awful.tag.incmwfact(0.05)          end,
       {description = "increase master width factor", group = "Layout"}),
   awful.key({ modkey, altkey }, "Down",     function () awful.tag.incmwfact(-0.05)          end,
       {description = "decrease master width factor", group = "Layout"}),

   -- Increment Columns Number
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol(1, nil, true)    end,
       {description = "increase the number of columns", group = "Layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
       {description = "decrease the number of columns", group = "Layout"}),

   -- Dynamic tagging
   awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
       {description = "move tag to the left", group = "Tag"}),
   awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
       {description = "move tag to the right", group = "Tag"})
)

clientkeys = my_table.join(
   
   awful.key({ modkey }, "f", 
       function (c)
           c.fullscreen = not c.fullscreen
           c:raise()
       end,
       {description = "toggle fullscreen", group = "Client"}),

   awful.key({ "Control" }, "q", function (c) c:kill() end,
       {description = "close", group = "Client"}),

   awful.key({ "Control" }, "e", function (c) c.minimized = true end,
       {description = "minimize", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
   local descr_view, descr_toggle, descr_move, descr_toggle_focus
   if i == 1 or i == 9 then
       descr_view = {description = "view tag #", group = "Tag"}
       descr_toggle = {description = "toggle tag #", group = "Tag"}
       descr_move = {description = "move focused client to tag #", group = "Tag"}
       descr_toggle_focus = {description = "toggle focused client on tag #", group = "Tag"}
   end
   globalkeys = my_table.join(globalkeys,
       -- View tag only.
       awful.key({ modkey }, "#" .. i + 9,
                 function ()
                       local screen = awful.screen.focused()
                       local tag = screen.tags[i]
                       if tag then
                          tag:view_only()
                       end
                 end,
                 descr_view),
       -- Toggle tag display.
       awful.key({ modkey, "Control" }, "#" .. i + 9,
                 function ()
                     local screen = awful.screen.focused()
                     local tag = screen.tags[i]
                     if tag then
                        awful.tag.viewtoggle(tag)
                     end
                 end,
                 descr_toggle),
       -- Move client to tag.
       awful.key({ modkey, "Shift" }, "#" .. i + 9,
                 function ()
                     if client.focus then
                         local tag = client.focus.screen.tags[i]
                         if tag then
                             client.focus:move_to_tag(tag)
                         end
                    end
                 end,
                 descr_move),
       -- Toggle tag on focused client.
       awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                 function ()
                     if client.focus then
                         local tag = client.focus.screen.tags[i]
                         if tag then
                             client.focus:toggle_tag(tag)
                         end
                     end
                 end,
                 descr_toggle_focus)
   )
end

-- Client Mouse Buttons
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)