args = {...}

if args[1] == nil then
    args[1] == "front"
end

if args[2] == nil then
    args[2] = 1
end



if args[1] == "right" or args[1] == "r" then
    turtle.turnRight()
elseif args[1] == "left" or args[1] == "l" then
    turtle.turnLeft()
elseif args[1] == "back" or args[1] == "b" then
    turtle.turnRight()
    turtle.turnRight()
end

if side == "front" then
    local block = turtle.inspect()
    sucker = turtle.suck
elseif side == "up" then
    local block = turtle.inspectUp()
    sucker = turtle.suckUp
elseif side == "down" then
    local block = turtle.inspectDown()
    sucker = turtle.suckDown
else
    error("wrong side")
end

--suck from chest
if block["name"] == "minecraft:chest" then
    local chest = peripheral.wrap(side)
    contents = chest.list
    
    print()



--suck from ground
while tonumber(args[1]) > 0 do
    sucker()
    args[1] = args[1] - 1
end
