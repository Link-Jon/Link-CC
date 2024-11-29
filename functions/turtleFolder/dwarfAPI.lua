--Old function just in case
turtleDig = turtle.dig
turtleDigUp = turtle.digUp
turtleDigDown = turtle.digDown

function dig(side, goBack)
    
    if side == nil then
        side = "front"
    end
    
    side = string.lower(side)

    if side == "front" or side == "foward" or side == "f" then
        while turtle.detect() do
            turtleDig()
        end
    elseif side == "top" or side == "up" or side == "t" then
        while turtle.detectUp() do
            turtleDigUp()
        end
    elseif side == "down" or side == "below" or side == "d" then
        turtleDigDown()    
    elseif side == "left" or side == "l" then
        turtle.turnLeft()
        while turtle.detect() do
            turtle.dig()
        end
        if goBack then
            turtle.turnRight()
        end
    elseif side == "right" or side == "r" then
        turtle.turnRight()
        while turtle.detect() do
            turtle.dig()
        end
        if goBack then
            turtle.turnLeft()
        end
    elseif side == "back" or side == "b" then
        turtle.turnRight()
        turtle.turnRight()
        while turtle.detect() do
            turtle.dig()
        end
        if goBack then
            turtle.turnRight()
            turtle.turnRight()
        end
    end
end

function quarry(dist, lengthSet)

    term.clear()
    term.setCursorPos(1,1)
    term.write("depth: "..1)
    term.setCursorPos(1,2)
    term.write("row: "..1)
    term.setCursorPos(1,3)
    term.write("column: "..1)

    for depth = 1, dist do -- dist
        for row = 1, 1+lengthSet do -- row
            for column = 1, lengthSet do -- column
            --SIMPLE VERS, NEEDS UPDATE TO USE GPS
                turtle.dig()
                turtle.forward()

                term.setCursorPos(1, 3) --var tracker
                term.clearLine()
                term.write("column: "..column)
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

    end

    for depth = 1, dist do
        turtle.up()
    end 

    return true
end



function tree()
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

return {
    turtle.dig = dig,
    dig = dig,
    dwarf = {
        dig = dig,
        tree = tree,
        quarry = quarry
    }
}
