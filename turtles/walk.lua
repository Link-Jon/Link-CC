--Todo
--wait why doesnt this use moveAPI
--was it not made yet?
--past me is annoying.

args = {...}

local how = string.lower(args[1])
--[[how = {"stairs"}--]]

local side = string.lower(args[2])
--side default
if side == nil then; side = "front"; end

local dist = tonumber(args[3])
--dist default
if dist == nil then; dist = 1; end

if side == "back" or side == "b" then
    turtle.turnRight()
    turtle.turnRight()
elseif side == "right" or side == "r" then
    turtle.turnRight()
elseif side == "left" or side == "l" then
    turtle.turnLeft()
end

if how == "stairs" then
    if side == "up" then
        changeStair = turtle.up
    elseif side == "down" then
        changeStair = turtle.down
    else
        error("Incorrect direction, need 'up' or 'down', got "..side)
    end
    
    while dist > 0.499 do
        changeStair()
        turtle.forward()
        dist=dist-1
    end
end
     
