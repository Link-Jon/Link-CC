--Movement function tweaks to
--Save my sanity. Hopefully.

require("dwarfAPI")

turtleForward = turtle.forward
turtleTurnLeft = turtle.turnLeft
turtleTurnRight = turtle.turnRight
turtleUp = turtle.up
turtleDown = turtle.down

function turtleTurnAround()
    turtleTurnRight()
    turtleTurnRight()
end


function go(dist,direction,digBool)
    --dist = whole positive number
    --direction = string, side.
    
    --Compatibility with 
    --turtleForward()
    if num == nil then
        num = 1
    end

    turtleDig = turtle.dig
    if side ~= nil and side ~= "forward" or side ~= "f" then

        if string.lower(side) == "left" or string.lower(side) == "l" then
            turtleTurnLeft()
        elseif string.lower(side) == "right" or string.lower(side) == "r" then
            turtleTurnRight()
        elseif string.lower(side) == "back" or string.lower(side) == "b" then
            turtleTurnAround()
        elseif string.lower(side) == "up" or string.lower(side) == "u" then
            turtleMove = turtle.up
            turtleDig = turtle.digUp
        elseif string.lower(side) == "down" or string.lower(side) == "d" then
            turtleMove = turtle.down
            turtleDig = turtle.digDown
        end
    end



    if dist < 0 then
        print("moveAPI.lua - Warn: function 'forward()' recieved negative distance )   
    end
    
    while dist > 0.499 do
        turtleMove()
        if digBool and turtle.detect() then
            turtleDig()
        elseif turtle.detect() then
            print("Mining disabled, movement stopped")
            return dist
            --return remaining distance.
        end
        dist = dist-1
    end
end

-- GPS 

--required by literally anything program i use to move, as if not the track will be lost.


--open file currLocation
--constantly update it with relative position
--have position be a table {name,x,y,z}
--NEED TO KNOW FACING DIRECTION
--how about x is north and z is east.

gpsFilename = "moveGPSstorage.txt"

function forward()
    if turtle.foward() then
        increaseFacing()
        return true
    else; return false; end
end

function turnLeft()
    updateFacing()
end

function initGPS(override)
    --100% for preventing files of coords being lost
    if fs.exists(gpsFilename) and not override then
        error("gps file already made. (call initGPS(true) to override)")
    else if override then
        backupText = "backup"
        cycleNum = 1
        while fs.exists(gpsFilename..backupText..cycleNum) do
            cycleNum=cycleNum+1
        end
        fs.copy(gpsFilename, gpsFilename..backupText..cycleNum)
        print("GPS Data overriden. Backup made.")
    end

    gpsFS = fs.open(gpsFilename, "w")
    
    --set 0,0,0 and direction
    print("Insert current facing direction")
    print("{north, south, east, west}")
    facingDirection = 

    temp = textutils.serialize({"facing" = "north","currLocation" = {0, 0, 0}})
    gpsFS.write("return {"temp"\n}")
    gpsFS.close()
    return true

end

--[[
Facing direction shenanagins
Front = north

--]]
--[[
function increaseFacing()
    

    gpsFS = require(gpsFilename)
    
    gpsData =

end

function updateFacing()

    if 

end]]