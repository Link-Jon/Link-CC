--Todo
--Completed.
--Maybe find a way to run 'drop' in shell with drop.lua not in root?
--These convience functions are nice, but they are filling root fast.

args = {...}

--[[
drop {start slot} {end slot} {side}
]]

if args[3] == "front" or args[3] == "forward" or args[3] == "f" then
    dropDir = turtle.drop
elseif args[3] == "down" or args[3] == "d" then    
    dropDir = turtle.dropDown
elseif args[3] == "up" or args[3] == "u" then
    dropDir = turtle.dropUp
else
    dropDir = turtle.drop
end

for i = args[1],args[2],1 do
    turtle.select(i)
    dropDir()
end
