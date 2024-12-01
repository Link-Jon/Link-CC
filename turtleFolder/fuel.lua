--Todo
--Completed.
--Maybe find a way to run 'fuel' in shell with fuel.lua not in root?
--These convience functions are nice, but they are filling root fast.

--oh also.. this could actually be done properly and then replace computercraft's refuel.lua

args = {...}

if args[2] == nil then
    args[2] = 1
else
    args[2] = tonumber(args[2])
end

if args[1] then
    turtle.select(tonumber(args[1]))
    turtle.refuel(args[2])
end

print(turtle.getFuelLevel())
