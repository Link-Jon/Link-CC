local args = {...}
local modem = peripheral.wrap("modem")
if modem then modem.open(220) end

function vprint(str) do end end
    -- so vprint is a REAL function, even when not verbose.
require("storageHall")

if args[1] == "scan" then
    inspectStorage()

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

startload = os.time()
term.clear()
term.setCursorPos(1,1)

ui.define.text({1,1},"-----------Storage Manager------------","minititle")
ui.draw("minititle")

ui.define.text({3,2},"Welcome! What would you like to do?","welcomemsg")
ui.draw("welcomemsg")
--write("request items; scan inventory; re-init; help\n")

--Im 99% sure my use is not the same
--as normal v/h sync, but
--these two keep track of current cursor pos
--to help in locating the next screen object  
local vsync = 6 
local hsync = 5

--request button
hsync, id = ui.define({
    id = "request", 
    type = "button", 

    text = "request", 
    pos = {hsync, vsync},

    action = ui.itemMenu,
    near = {id = "request", right = "scan"}
})


--seperator left
hsync, id = ui.define({
    id = "seperator", 
    save = "both",

    text = " | ", 
    pos = { left = {hsync, vsync}}
})


--scan button
hsync, id = ui.define({
    id = "scan", 
    type = "button",

    text = "rescan", 
    pos = {hsync, vsync},

    action = inspectStorage,
    near = {id = "scan", left = "request", right = "init"}
})


--seperator right
hsync, id = ui.define({
    id = "seperator", 
    type = "pos",

    pos = {right = {hsync, vsync}},
})


--init button
hsync, id = ui.define({
    id = "init", 
    type = "button",

    text = "init", 
    pos = {hsync, vsync},

    action = ui.initPrep,
    near = {id = "init", left = "scan"}
})


--------

--next = ui.text({next, BL}," | ")
--actually, lemmie just make this a second row...
--next = 5

--next = ui.button({next, BL+2},"help", {id= "help", up = "request"}, helpShell)
--next = ui.text({next, BL+2}," | ")
loadtime = 100*(os.time() - startload)
loadtime = math.floor(loadtime)
loadticks = loadtime/5
print("Load: "..loadtime.."ms  ||  "..loadticks.."ticks")
sleep(1)


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
        redraw = {
            text = true,
            button = true,
            reuse = true
        }
    end

    if redraw.text then
        ui.draw.text("minititle")
        ui.draw.text("welcomemsg")
    end

    if redraw.button then
        ui.draw.button("request")
        ui.draw.button("scan")
        ui.draw.button("init")
    end
    
    if redraw.reuse then
        ui.draw.reusable("seperator","left")
        ui.draw.reusable("seperator","right")
    end

end

mainMenu("all")

--select = coroutine.create(ui.selector)
--highlighter = coroutine.wrap(ui.highlightSelected)
--highlighter()
settings.set("sys.storage.ui.menu","main")
settings.set("sys.storage.ui.selected", "request")
while true do
    --Selects buttons, and pushes them
    
    ui.selector()
    sleep(0)
    
end