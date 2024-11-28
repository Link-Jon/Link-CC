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