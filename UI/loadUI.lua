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

local currPage = ui.loadPage(args[1])
settings.set("sys.ui.selected", currPage.defaultButton)
currPage.define()
currPage.draw()


while true do
    local prevPage = currPage
    
    --Selects buttons, and pushes them
    ui.selector()
    currPage = ui.loadPage()


    if quit or currPage == "quit" then; 
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColour(colours.white)
        term.setBackgroundColour(colours.black)
        break; 
    end

    if currPage ~= prevPage then
        currPage.define()
        currPage.draw()
    end

end