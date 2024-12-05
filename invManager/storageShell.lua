startload = os.clock()
local args = {...}
local modem = peripheral.wrap("modem")
if modem then modem.open(220) end

function vprint(str) do end end
    -- so vprint is a REAL function, even when not verbose.
local storage = require("storageHall")

if args[1] == "scan" then
    storage.inspectStorage()

    function vprint(text)
        term.setTextColor(2^6)
        print(text)
        term.setTextColor(2^0)
        sleep(0.5)
    end

elseif args[1] == "verbose" then
    function vprint(text)
        term.setTextColor(2^6)
        print(text)
        term.setTextColor(2^0)
        sleep(0.5)
    end
elseif args[1] == "step" then
    function vprint(text)
        term.setTextColor(2^6)
        print(text)
        term.setTextColor(2^0)
        io.read()
    end
end


require("logic")
local ui = require("uiAPI")

--ui.test()
local next = 1
local len = 0


--Main Menu


term.clear()
term.setCursorPos(1,1)

ui.define({
    pos = {1,1},
    text = "-----------Storage Manager------------",
    id = "minititle"})

ui.define({
    pos = {3,2},
    text = "Welcome! What would you like to do?",
    id = "welcomemsg"})
--write("request items; scan inventory; re-init; help\n")

--Im 99% sure my use is not the same
--as normal v/h sync, but
--these two keep track of current cursor pos
--to help in locating the next screen object  
local vsync = 6 
local hsync = 5

--request button
hsync = ui.define({
    id = "request", 

    text = "request",
    style = "button",

    pos = {hsync, vsync},

    action = ui.itemMenu,
    near = {id = "request", right = "scan", down = "quit"}
})


--seperator left
hsync = ui.define({
    id = "sepLeft", 

    style = "seperator",
    text = " | ", 
    pos = {hsync, vsync}
})


--scan button
hsync = ui.define({
    id = "scan", 

    text = "rescan", 
    style = "button",

    pos = {hsync, vsync},

    action = storage.inspectStorage,
    near = {id = "scan", left = "request", right = "init", down = "quit"}
})


--seperator right
hsync = ui.define({
    id = "sepRight", 

    style = "seperator",
    text = " | ",
    pos = {hsync, vsync}
})


--init button
hsync = ui.define({
    id = "init", 

    text = "init", 
    style = "button",

    pos = {hsync, vsync},

    action = ui.initPrep,
    near = {id = "init", left = "scan", down = "quit"}
})


ui.define({
    id = "quit",

    text = "quit",
    style = "button",

    pos = {posData["scan"][1], (vsync + 3)},

    action = function(); quit = true end;
    near = {id = "quit", up = "scan", left = "request", right = "init"}
})
--------

--next = ui.text({next, BL}," | ")
--actually, lemmie just make this a second row...
--next = 5

--next = ui.button({next, BL+2},"help", {id= "help", up = "request"}, helpShell)
--next = ui.text({next, BL+2}," | ")
term.clear()
term.setCursorPos(1,1)
function mainMenu(redraw)


    --after seeing this i now see i really really need to make something to
    --just kinda... handle this. aka, make an actual api?
    --but really, i just need a flag of weither the
    --text / button / reusable is currently technically visible.
    --and draw all currently visible features...
    --ui.redraw, sigh.
    --...
    --probllly ui.draw.redraw lol

    if redraw == "all" then
        term.clear()
        redraw = {
            text = true,
            button = true,
            reuse = true
        }
    end

    if redraw.text then
        ui.draw("minititle")
        ui.draw("welcomemsg")
    end

    if redraw.button then
        ui.draw("request")
        ui.draw("scan")
        ui.draw("init")
        ui.draw("quit")
    end
    
    if redraw.reuse then
        ui.draw("sepLeft")
        ui.draw("sepRight")
    end

end

settings.set("sys.storage.ui.menu","main")
settings.set("sys.storage.ui.selected", {id = "request", right = "scan", down = "quit"})

mainMenu("all")

--select = coroutine.create(ui.selector)
--highlighter = coroutine.wrap(ui.highlightSelected)
--highlighter()

while true do
    --Selects buttons, and pushes them
    ui.selector()

    local menu = settings.get("sys.storage.ui.menu")
    if menu == "main" then
        mainMenu("all")
    elseif menu == "requestMenu" then
        ui.itemMenu()
    end

    if quit then; 
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColour(colours.white)
        term.setBackgroundColour(colours.black)
        break; 
    end

end