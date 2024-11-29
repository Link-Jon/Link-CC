--Todo...?
--Why did i make this?
--Digs a '+' shaped tunnel.
--???
--is this even usefull? why isnt this in dig.lua?
--whatever. im only doing todos for right now


args = {...}

require("dwarfAPI")

dist = tonumber(args[1])

for i = 1,dist do

    dig()
    turtle.forward()
    dig("left", true)
    dig("right", true)
    dig("up")
    dig("down")
    
end