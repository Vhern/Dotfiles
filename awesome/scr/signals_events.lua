-- No borders when rearranging only 1 non-floating or maximized client // TODO: gap only with multiples windows
screen.connect_signal("arrange", function (s)
   local only_one = #s.tiled_clients == 1
   for _, c in pairs(s.clients) do
       if only_one and not c.floating or c.maximized then
           c.border_width = 0
       else
           c.border_width = beautiful.border_width
       end
   end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = vi_focus})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) 
    c.border_color = beautiful.border_normal

    -- Temporal Apps
    if c.name == "Qalculate!" or
        c.name == "Free Download Manager" then
        c:kill()
    end
end)