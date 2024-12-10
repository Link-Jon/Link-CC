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

settings.set("sys.ui.menuPath", false)
local currMenu = ui.loadMenu(args[1])
settings.set("sys.ui.selected", currMenu.defaultButton)
currMenu.define()
currMenu.draw()
local prevMenu = currMenu

while true do
    prevMenu = currMenu
    
    --Selects buttons, and pushes them
    ui.selector()
    currMenu = ui.loadMenu()


    if quit or currMenu == "quit" then; 
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColour(colours.white)
        term.setBackgroundColour(colours.black)
        break; 
    end

    if currMenu.name ~= prevMenu.name then
        term.clear()
        term.setCursorPos(1,1)
        local succ, why = pcall(currMenu.define)
        local defined = "false"
        if succ then
            defined = "true"
            succ, why = pcall(currMenu.draw)
        end

        if not succ then
            term.clear()
            term.setCursorPos(1,1)
            write("Failed to load "..currMenu.name.." || defined? "..defined.."Error:")
            printError(why)
            break
        end
    end

end