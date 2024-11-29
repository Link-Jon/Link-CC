--Movement function tweaks to
--Save my sanity. Hopefully.

turtle = {}

function move(side,dist,digBool)
    --dist = whole positive number
    --side = string, side.
    
    --Compatibility with 
    --turtleForward()
    if num == nil then
        num = 1
    end

    local turtleMove = ccturtle.forward
    local turtleDig = ccturtle.dig
    if side ~= nil and side ~= "forward" or side ~= "f" then

        if string.lower(side) == "left" or string.lower(side) == "l" then
            turtle.turnLeft()
        elseif string.lower(side) == "right" or string.lower(side) == "r" then
            turtle.turnRight()
        elseif string.lower(side) == "back" or string.lower(side) == "b" then
            turtle.turnRight(); turtleRight()
        elseif string.lower(side) == "up" or string.lower(side) == "u" then
            turtleMove = turtle.up
            turtleDig = turtle.digUp
        elseif string.lower(side) == "down" or string.lower(side) == "d" then
            turtleMove = turtle.down
            turtleDig = turtle.digDown
        end
    end

    if dist < 0 then
        print("moveAPI.lua - Warn: function 'forward()' recieved negative distance ")   
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
--Unsure if this is a good idea, but i will use settings api to do this...
gpsFilename = "moveGPSstorage.txt"

function forward()
    if ccturtle.foward() then
        updateLocation("forward")
        return true
    else; return false; end
end

function turnLeft()
    if ccturtle.turnLeft() then
        updateFacing("left")
        return true
    else; return false; end
end

function turnRight()
    if ccturtle.turnRight() then
        updateFacing("right")
        return true
    else; return false; end
end

function up()
    if ccturtle.up() then
        updateLocation("up")
        return true
    else; return false; end
end

function down()
    if turtle.down() then
        updateLocation("down")
        return true
    else; return false; end
end

function back()
    if turtle.back() then
        updateLocation("back")
        return true
    else; return false; end
end

--https://github.com/fnuecke/lama/blob/master/apis/lama
--i cannot reassign the turtle api without it being recursive, so i shall use this.
--very beautiful code, really.
function hijackTurtleAPI(restore)
    -- Wrap methods to avoid accidentally passing parameters along. This is
    -- done to make sure behavior is the same even if the functions are
    -- called with (unused/invalid) parameters.
    if restore then
        if not turtle._lama then return end
        turtle.forward   = turtle._lama.forward
        turtle.back      = turtle._lama.back
        turtle.up        = turtle._lama.up
        turtle.down      = turtle._lama.down
        turtle.turnRight = turtle._lama.turnRight
        turtle.turnLeft  = turtle._lama.turnLeft
        --turtle.refuel    = turtle._lama.refuel
        turtle._lama = nil
    else
        if turtle._lama then return end
        turtle._lama = {
            forward   = turtle.forward,
            back      = turtle.back,
            up        = turtle.up,
            down      = turtle.down,
            turnRight = turtle.turnRight,
            turnLeft  = turtle.turnLeft
            --refuel    = turtle.refuel
        }
        turtle.forward   = function() return forward() ~= false end
        turtle.back      = function() return back() ~= false end
        turtle.up        = function() return up() ~= false end
        turtle.down      = function() return down() ~= false end
        turtle.turnRight = function() return turnRight() ~= false end
        turtle.turnLeft  = function() return turnLeft() ~= false end
        --turtle.refuel    = function() return refuel() ~= false end
    end
end

--[[
function cardinalConform()
maybe
end]]

function initGPS(facingDirection, restore)
    --100% for preventing files of coords being lost
    
    local temp = hijackTurtleAPI(restore)
    if restore then return temp end

    --set 0,0,0 and direction
    repeat
    print("Insert current facing direction")
    print("{north, south, east, west}")
    facingDirection = string.lower(io.read())
    until facingDirection == "north" or facingDirection == "south" or facingDirection == "east" or facingDirection == "west"

    settings.define("sys.movement.x", {
        description = "X axis location",
        default = 0,
        type = "number"
    })    
    settings.define("sys.movement.y", {
        description = "Y axis location",
        default = 0,
        type = "number"
    })    
    settings.define("sys.movement.z", {
        description = "Z axis location",
        default = 0,
        type = "number"
    })
    settings.define("sys.movement.facingNum", {
        description = "Facing cardinal direction {north=1, east=2, south=3, west=4}",
        default = 1,
        type = "number"
    })
    settings.define("sys.movement.facingStr", {
        description = "Facing cardinal direction",
        default = "north",
        type = "string"
    })

    local facingArry = {north=1, east=2, south=3, west=4}
    settings.set("sys.movement.facingNum",facingArry[facingDirection])
    settings.set("sys.movement.facingStr",facingDirection)
    --maybe? idk yet
    --[[
    temp = textutils.serialize({"facing" = facingDirection,"currLocation" = {0, 0, 0}})
    gpsFS.write("return {"temp"\n}")
    gpsFS.close()]]

    return true
end

--[[
Facing direction shenanagins
Front = north

--]]

function updateLocation(direction)
    
    facing = settings.get("sys.movement.facingStr")
    
    if direction == "forward" then
        inc = 1
    elseif direction == "back" then
        inc = -1
    elseif direction == "up" then
        --pos y
        y = settings.get("sys.movement.y")
        y = y + 1
        settings.set("sys.movement.y", y)
        return true
    elseif direction == "down" then
        --neg y
        y = settings.get("sys.movement.y")
        y = y - 1
        settings.set("sys.movement.y", y)
        return true
    else
        error("Incorrect direction "..direction)
    end
    
    if facing == "north" then
        --negative z
        z = settings.get("sys.movement.z")
        z = z - inc
        settings.set("sys.movement.z", z)
        return true
    elseif facing == "south" then
        --positive z
        z = settings.get("sys.movement.z")
        z = z + inc
        settings.set("sys.movement.z", z)
        return true
    elseif facing == "east" then
        --positive x
        x = settings.get("sys.movement.x")
        x = x + inc
        settings.set("sys.movement.x", x)
        return true
    elseif facing == "west" then
        --negative x
        x = settings.get("sys.movement.x")
        x = x - inc
        settings.set("sys.movement.x", x)
        return true
    else
        error("Facing incorrectly set as "..facing)
    end

end

function updateFacing(turnDir)

    directions = {north=1, east=2, south=3, west=4}
    
    if turnDir == "left" then
        local selecter = 3
    elseif turnDir == "right" then
        local selecter = 1
    end

    facing = settings.get("sys.movement.facingNum")
    facing = facing+directions[turnDir]
    if facing > 4 then facing = facing % 4 end
    settings.set("sys.movement.facingNum", facing)
    settings.set("sys.movement.facingStr", direction[facing])
end

function getLocation(xyz)
    pos = {x = settings.get("sys.movement.x"), y = settings.get("sys.movement.y"), z = settings.get("sys.movement.z")}
    if xyz then
        return pos[xyz]
    else
        return pos
    end
end

--Turns the turtle to look at side.
--returns the side needed to look back.
function look(side)
    side = conformSide(side)

    if side == "front" or side == "up" or side == "down" then
        return true
    elseif side == "left" then
        turtle.turnLeft()
        return "right"
    elseif side == "right" then
        turtle.turnRight()
        return "left"
    elseif side == "back" then
        turtle.turnRight()
        turtle.turnRight()
        return "back"
    end
end

return {
    initGPS = initGPS,
    getLocation = getLocation,
    hijackTurtleAPI = hijackTurtleAPI
}