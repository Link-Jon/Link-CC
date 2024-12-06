
local storage = require("storageHall")
local ui = require("uiAPI")

local function define()
    local next = 1
    local len = 0

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

        action = function() settings.set("sys.ui.page","requestList") end,
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
end



local function draw(redraw)

    if redraw == "all" then
        term.clear()
        redraw = {
            text = true,
            button = true,
            reuse = true
        }
    elseif type(redraw) == "string" then
        redraw = {redraw}
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
    
    --Generally, simple text
    if redraw.reuse then
        ui.draw("sepLeft")
        ui.draw("sepRight")
    end

end

local main = {
    define = define,
    draw = draw,
    defaultButton = "request"
}

return main
