--[[args = {...}
require("logic")

pattern = string.lower(args[1])
material = string.lower(args[2])
replace = nilcheck(args[3])
--]]

--[[
for each pattern to build...
{patternName, x, y, ect.}, 
{{{width, length, height}, {widthOffset, lengthOffset, heightOffset}}, {x}, {y}, {ect}}
--length will always go away from the turtle
--do i make the offset an array....
--]]
function build(patterns, details)
    
    if type(patterns) == "string" then
        patterns = {patterns}
    end
    
    for iter = 1, #patterns do

        width = details[iter][1][1]
        length = details[iter][1][2]
        height = details[iter][1][3]

        wOffset = details[iter][2][1]
        lOffset = details[iter][2][2]
        hOffset = details[iter][2][3]

    end

    --maybe i should make a manualGPS system

end