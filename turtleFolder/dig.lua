--Todo
--Completed.
--Maybe find a way to run 'dig' in shell with dig.lua not in root?
--These convience functions are nice, but they are filling root fast.

--Edit these to change size of
--dig quarry
quarryDepth = 50
quarrySize = 5

require("dwarfAPI")
require("logic")
args = {...}

--[[if not args[1] or type(args[1]) ~= "string" then
    error("to make msg later - arg1")
end -- makeerrror cehck
--]]


side = args[1]
goBack = nilcheck(args[2])

if not side then
    side = "front"
end

--dist = args[?]

--[[
if side == "vein" then
local bool, baseOre = turtle.inspect()

turtle.dig()
turtle.forward()

bool, ore = turtle.inspect()

if ore == baseOre then
--]]

if side == "tree" then
    dwarf.tree()
elseif side == "quarry" then
    dwarf.quarry(quarryDepth, quarrySize)
else

    --generic dig
    if side == "front" or side == "foward" or side == "f" then
        turtleDig()
    elseif side == "top" or side == "up" or side == "t" then
        turtleDigUp()
    elseif side == "down" or side == "below" or side == "d" then
        turtleDigDown()
    elseif side == "left" or side == "l" then
        turtle.turnLeft()
        turtleDig()
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