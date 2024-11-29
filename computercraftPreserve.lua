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

    --turtle functions
    --Comments note where its reassigned.
    turtle = {

        --dwarfAPI
        dig = turtle.dig,
        digUp = turtle.digUp,
        digDown = turtle.digDown,

        --moveAPI
        forward = turtle.forward,
        turnLeft = turtle.turnLeft,
        turnRight = turtle.turnRight,
        back = turtle.back,
        up = turtle.up,
        down = turtle.down,

        detect = turtle.detect,
        detectUp = turtle.detectUp,
        detectDown = turtle.detectDown
    },

    --logic
    print = print,
    write = term.write
}

return cc
