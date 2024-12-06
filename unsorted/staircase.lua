--Todo
--This should probably be inside of dig.lua or dwarfAPI.lua

args = {...}

require("dwarfAPI")
turtle.dig = dig

if args[1] == nil or type(tonumber(args[1])) ~= "number" then

    error([[Incorrect usage!
    staircase {distance} [height]
    
    Mines a staircase distance 
    number of blocks down.
    height is how far the turtle digs up.
    default 3, range: h>=3
    ]])
end


dist = tonumber(args[1])
if args[2] == nil then
    height = 3
else
    height = (args[2])
end
--Stair loop
while dist > 0 do

    currHeight = 2

    turtle.dig()
    turtle.forward()
    
    --Dig left side going up
    turtle.turnLeft()
    while currHeight < height do
        turtle.dig()
        turtle.dig("up")
        turtle.up()
        currHeight = currHeight + 1
    end
    turtle.dig()

    --Dig right side going down
    turtle.turnRight()
    turtle.turnRight()
    while currHeight < 1 do
        turtle.dig()
        turtle.down()
        currHeight = currHeight - 1
    end

    turtle.dig()
    turtle.dig("back",true)
    turtle.turnRight()

    dist = dist-1
end
