
--Current version of storage/main.lua

local storage = require("storageHall")
local ui = require("uiAPI")



local function define()
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
end



local function draw(redraw)

    --We can draw everything in one call, 
    --instead of calling draw thrice.
    --This can be changed to include more or less categories also.
    if redraw == "all" or redraw == nil then
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
        --[[
        Things that probably dont need to be
        redrawn constantly
        ]]
    end

    if redraw.button then
        ui.draw("request")
        ui.draw("scan")
        ui.draw("init")
        ui.draw("quit")
        --[[
        Meant for ui.selector to use, 
        so it can redraw all buttons.
        ]]
    end
    

    if redraw.reuse then
        ui.draw("sepLeft")
        ui.draw("sepRight")
        --[[
        This is probably technically unneeded. 
        Functionally, just another category

        Originally, was for IDs that used the same
        textID but different posID
        ]]
    end

end

local main = {
    define = define,
    draw = draw,
    defaultButton = "request"
}

return main
