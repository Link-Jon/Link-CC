local ui = require("uiAPI")
local storage = require("storageHall")


local function define()
    

    initLength = 0
    initSides = {}
    initBlock = ""


    ui.define({
        id = "lengthText",

        text = "Length of hall:",
        pos = {2,3}
    })
    

    ui.define({
        id = "lengthUP",

        text = "+1",
        pos = {5,5},

        action = function(extra) 
        
            if extra == keys.leftShift or extra == keys.rightShift then
                initLength = initLength + 10
            elseif extra == keys.leftCtrl or extra == keys.leftCtrl then
                initLength = initLength + 5
            else
                initLength = initLength + 1
            end
        
        end, --increase length var
        near = {
            id = "lengthUP",
            down = "lengthCount",
            right = "confirm"
        }
    })

    ui.define({
        id = "lengthCount",

        text = initLength, --should be current length :/
        pos = {5,7}, 
    
        action = function() end,
        near = {
            id = "lengthCount",
            up = "lengthUP",
            down = "lengthDOWN",
            right = "confirm"
        }
    })

    ui.define({
        id = "Lengthtext",

        text = "Length of hall:",
        pos = {5,9}  --ill figure it out later, probably.
    })

    --why dont i just ask user for a number??????



    local _, termY = term.getSize()

    ui.define({
        id = "inputPrep",

        text = ">",
        pos = {1,termY}
    })

    --

    ui.define({
        id = "sidesText",

        text = "Chest sides:",
        pos = {2,3}
    })--this one DOES need to be changed to be a proper ui...


end
--ugh screw it this is functional for now.
--sigh.
local function draw()
    term.clear()
    ui.draw("lengthText")
    ui.draw("inputPrep")
    local input = io.read()
    local length = tonumber(input)

    term.clear()
    ui.draw("sidesText")
    ui.draw("inputPrep")
    input = io.read()

    local sides = textutils.unserialise(input)
    storage.init({"length",length}, sides)


    local path = settings.get("sys.ui.pagePath")
    table.remove(path)
    settings.set("sys.ui.pagePath", path)
    settings.set("sys.ui.page", path[#path])
end

return {
    define = define,
    draw = draw,
    defaultButton = "wait"
}