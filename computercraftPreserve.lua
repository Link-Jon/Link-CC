--This is an attempt to copy any of the things that i change
--from _G.name to _G.cc.name

--it uh.. may or may not work. 
--But because i want to overwrite some of CC's functions,
--*its going to have to work*

--hey btw if the first plan doesnt work,
--You could try saving the binary of each function in a file, and use those...
--Probably have to update the file each time? dunno atm

--if its allready been done, dont repeat it.
if cc then return cc end


--ugh how do i do this.
--cause every time i did before i end up doing infinity recursion
--pain.

cc = {
    turtle = turtle,
    --in this state, print()

    --[[
    --dwarfAPI
    turtle.dig = turtle.dig,
    turtle.digUp = turtle.digUp,
    turtle.digDown = turtle.digDown,

    --moveAPI
    turtle.forward = turtle.forward,
    turtle.turnLeft = turtle.turnLeft,
    turtle.turnRight = turtle.turnRight,
    turtle.back = turtle.back,
    turtle.up = turtle.up,
    turtle.down = turtle.down,

    turtle.detect = turtle.detect,
    turtle.detectUp = turtle.detectUp,
    turtle.detectDown = turtle.detectDown,
    ]]

    --logic
    print = print,
    term = term
}

return cc
