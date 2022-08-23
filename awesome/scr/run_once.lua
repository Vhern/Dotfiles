-- {{{ Autostart windowless processes
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
   for _, cmd in ipairs(cmd_arr) do
         awful.spawn.with_shell("pgrep -u $USER -fx '" .. cmd .. "' > /dev/null || (" .. cmd .. ")")
   end
end

-- Autostart apps
run_once({
   --"picom",
   "lxsession",
   "numlockx on", 
   "unclutter -root",
   "nitrogen --restore"
})

--[[
   local awful = require("awful")
local lfs   = require("lfs")

local function processwalker()
   local function yieldprocess()
      for dir in lfs.dir("/proc") do
        if tonumber(dir) ~= nil then
          local f, err = io.open("/proc/"..dir.."/cmdline")
          if f then
            local cmdline = f:read("*all")
            f:close()
            if cmdline ~= "" then
              coroutine.yield(cmdline)
            end
          end
        end
      end
    end
    return coroutine.wrap(yieldprocess)
end

function run_once(process, cmd)
   assert(type(process) == "string")
   local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

   for p in processwalker() do
      if p:find(process:gsub("[-+?*]", regex_killer)) then
         return
      end
   end
   return awful.util.spawn(cmd or process)
end

run_once("picom")
run_once("lxsession")
run_once("numlockx on")
run_once("unclutter -root")
run_once("nitrogen --restore")
]]