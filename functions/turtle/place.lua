args = {...}



if not args[1] then 
    side = "front"
else
    side = string.lower(args[1])
end

if args[2] then
    turtle.select(tonumber(args[2]))
end

if args[3] == "true" then
    goBack = true
end

if side == "front" or side == "f" then
    turtle.place()
elseif side == "top" or side == "t" then
    turtle.placeUp()
elseif side == "down" or side == "d" then
    turtle.placeDown()
elseif side == "right" or side == "r" then
    turtle.turnRight()
    turtle.place()
    if goBack then
        turtle.turnLeft()
    end
elseif side == "left" or side == "l" then
    turtle.turnLeft()
    turtle.place()
    if goBack then
        turtle.turnRight()
    end
elseif side == "back" or side == "b" then
    turtle.turnRight()
    turtle.turnRight()
    turtle.place()
    if goBack then
        turtle.turnRight()
        turtle.turnRight()
    end
end

