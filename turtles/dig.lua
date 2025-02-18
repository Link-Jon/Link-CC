--Todo
--Completed.
--Maybe find a way to run 'dig' in shell with dig.lua not in root?
--These convience functions are nice, but they are filling root fast.

--Edit these to change size of
--dig quarry
quarryDepth = 50
quarrySize = 5

local dwarf = require("dwarfAPI")
local logic = require("logic")
args = {...}

--[[if not args[1] or type(args[1]) ~= "string" then
    error("to make msg later - arg1")
end -- makeerrror cehck
--]]


side = args[1]
goBack = logic.nilcheck(args[2])

if not side then
    side = "front"
end

--dist = args[?]

if side == "tree" then
    dwarf.tree()
elseif side == "quarry" then
    dwarf.quarry(quarryDepth, quarrySize)
elseif side == "plus" then
    for i = 1,dist do
        dig()
        turtle.forward()
        dig("left", true)
        dig("right", true)
        dig("up")
        dig("down")
    end
elseif side == "staircase" then
    
    if args[2] == nil or type(tonumber(args[2])) ~= "number" then

    error([[Incorrect usage!
    dig staircase {distance} [height]
    
    Mines a staircase distance 
    number of blocks down.
    height is how far the turtle digs up.
    default 3, range: h>=3
    ]])
    else
        args[2] = tonumber(args[2])
        args[3] = tonumber(args[3])
        dwarf.staircase(args[2],args[3])
    end
else

    --generic dig
    if side == "front" or side == "foward" or side == "f" then
        turtle.dig()
    elseif side == "top" or side == "up" or side == "t" then
        turtle.digUp()
    elseif side == "down" or side == "below" or side == "d" then
        turtle.digDown()
    elseif side == "left" or side == "l" then
        turtle.turnLeft()
        turtle.dig()
        if goBack then
            turtle.turnRight()
        end
    elseif side == "right" or side == "r" then
        turtle.turnRight()
        turtle.dig()
        if goBack then
            turtle.turnLeft()
        end
    elseif side == "back" or side == "b" then
        turtle.turnRight()
        turtle.turnRight()
        turtle.dig()
        if goBack then
            turtle.turnRight()
            turtle.turnRight()
        end
    end
end