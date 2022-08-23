awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    --placement = awful.placement.centered,
                    size_hints_honor = false
    }
   },

   -- Set Firefox to always map on the first tag on screen 1.
   --{ rule = { class = "Firefox" },
   --  properties = { screen = 1, tag = awful.util.tagnames[1] } },

   --{ rule = { class = "Gimp", role = "gimp-image-window" },
   --      properties = { maximized = true } },


   --{ rule = { role = { "pop-up" } }, properties = { floating = true }},
     
   { rule = { floating = true },
       properties = { ontop = true, placement = awful.placement.centered } },

   { rule_any = { 
   name = { 
       "Qalculate!",
       "Free Download Manager", 
       "Android Emulator - Pixel_3_XL_API_30:5554" },
   class = { 
       mini_browser, } },
       properties = { ontop = true, floating = true, placement = awful.placement.centered } },
}