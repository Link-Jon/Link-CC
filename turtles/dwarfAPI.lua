--Todo
--Im pretty sure this isnt functional currently.
--So... fix it.


--Old function just in case
local turtleDig = turtle.dig
local turtleDigUp = turtle.digUp
local turtleDigDown = turtle.digDown


local function dig(side, goBack)
    
    if side == nil then
        side = "front"
    end
    
    side = string.lower(side)

    if side == "front" or side == "foward" or side == "f" then
        while turtle.detect() do
            return turtleDig()
        end
    elseif side == "top" or side == "up" or side == "t" then
        while turtle.detectUp() do
            return turtleDigUp()
        end
    elseif side == "down" or side == "below" or side == "d" then
        return turtleDigDown()    
    elseif side == "left" or side == "l" then
        turtle.turnLeft()
        while turtle.detect() do
            return turtle.dig()
        end
        if goBack then
            turtle.turnRight()
        end
    elseif side == "right" or side == "r" then
        turtle.turnRight()
        while turtle.detect() do
            return turtle.dig()
        end
        if goBack then
            turtle.turnLeft()
        end
    elseif side == "back" or side == "b" then
        turtle.turnRight()
        turtle.turnRight()
        while turtle.detect() do
            return turtle.dig()
        end
        if goBack then
            turtle.turnRight()
            turtle.turnRight()
        end
    end
end

--[[
vein miner.
if side == "vein" then
local bool, baseOre = turtle.inspect()

turtle.dig()
turtle.forward()

bool, ore = turtle.inspect()

if ore == baseOre then
--]]

local function quarry(dist, lengthSet)

    modem = peripheral.find("modem")

    term.clear()
    term.setCursorPos(1,1)
    term.write("depth: "..1)
    term.setCursorPos(1,2)
    term.write("row: "..1)
    term.setCursorPos(1,3)
    term.write("column: "..1)

    if modem then
        modem.transmit(100,1,{depth=1,row=1,column=1})
    end

    local depthLast, rowLast, columnLast
    
    for depth = 1, dist do -- dist
        depthLast = depth
        for row = 1, 1+lengthSet do -- row
            rowLast = row
            for column = 1, lengthSet do -- column
                columnLast = column
            --SIMPLE VERS, NEEDS UPDATE TO USE GPS
                turtle.dig()
                turtle.forward()

                term.setCursorPos(1, 3) --var tracker
                term.clearLine()
                term.write("column: "..column)
                
                if modem then
                    modem.transmit(100,1,{depth=depthLast, row=rowLast, column=columnLast})
                end
            end

            if doTurn == turtle.turnLeft or doTurn == nil then
                doTurn = turtle.turnRight
            else; doTurn = turtle.turnLeft; end
            
            if row ~= lengthSet+1 then
                doTurn()
                turtle.dig()
                turtle.forward()
                doTurn()
            end

            term.setCursorPos(1, 2) --var tracker
            term.clearLine()
            term.write("row: "..row)
            if modem then
                modem.transmit(100,1,{depth=depthLast, row=rowLast, column=columnLast})
            end
        end

        turtle.digDown()
        turtle.down()
        --realign to hole
        doTurn()
        doTurn()
        doTurn()

        term.setCursorPos(1, 1) --var tracker
        term.clearLine()
        term.write("depth: "..depth)
        if modem then
            modem.transmit(100,1,{depth=depthLast, row=rowLast, column=columnLast})
        end

    end

    for depth = 1, dist do
        if turtle.detectUp() then
            turtle.digUp()
        end
        turtle.up()
    end

    return true
end



local function tree()
    if turtle.detect() then
        turtle.dig()
        turtle.forward()
    end
    counter = 0


    --theres probably a better way to do this
    while turtle.detectUp() == false and counter < 25 do
        turtle.up()
        counter = counter + 1
    end

    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end

    while turtle.detectDown()==false do
        turtle.down()
    end
end

local function staircase(dist, height)
    if type(dist) ~= "number" then
        return false
    end

    if height == nil then
        height = 3
    end
    --Stair loop
    while dist > 0 do
    
        currHeight = 2
    
        dig()
        turtle.forward()
        
        --Dig left side going up
        turtle.turnLeft()
        while currHeight < height do
            dig()
            dig("up")
            turtle.up()
            currHeight = currHeight + 1
        end
        dig()
    
        --Dig right side going down
        turtle.turnRight()
        turtle.turnRight()
        while currHeight > 1 do
            dig()
            turtle.down()
            currHeight = currHeight - 1
        end
    
        dig()
        dig("back",true)
        turtle.turnRight()
    
        dist = dist-1
    end
    
end

local dwarf = {
    dig = dig,
    tree = tree,
    quarry = quarry,
    staircase = staircase
}

return dwarf
