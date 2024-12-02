--returns clicked location
term.clear()

event, button, x, y = os.pullEvent("mouse_click")

term.setCursorPos(1,1)
print("x: "..x)
print("y: "..y)

term.setCursorPos(x,y)
term.setTextColor(2^11)
term.write("x")