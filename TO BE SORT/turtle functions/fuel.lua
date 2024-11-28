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
