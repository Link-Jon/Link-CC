local args = {...}
local ui = require("uiAPI")

function vprint(text)
    term.setTextColor(2^6)
    print(text)
    term.setTextColor(2^0)
    io.read()
end

if not args[1] then
    error("Need filename")
    --make this descriptive please.
end

ui.loadPage(args[1])

while true do
    --Selects buttons, and pushes them
    ui.selector()
    ui.loadPage()

    if quit then; 
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColour(colours.white)
        term.setBackgroundColour(colours.black)
        break; 
    end

end