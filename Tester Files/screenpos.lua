--returns clicked location
term.clear()

local cypher = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
local maxX, maxY = term.getSize()
for y = 1,maxY do
    term.setTextColour(2^y)
    for x = 1,maxX do
        term.setCursorPos(x,y)
        if x < 10 then
            term.write(x)
        else
            term.write(cypher[x-10])
        end
    end
end


local event, button, x, y = os.pullEvent("mouse_click")

term.clear()
term.setCursorPos(1,1)
print("x: "..x)
print("y: "..y)

term.setCursorPos(x,y)
term.setTextColor(2^11)
term.write("x")