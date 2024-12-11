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

        pos = {5,5},

        action = function(modifier)
            if not modifier then; modifier = 1; end
            initLength = initLength + modifier
        end, --increase length var

        keys = {
            equals = function(modifier)
                if not modifier then; modifier = 1; end
                initLength = initLength + modifier
            end,
            numPadAdd = function(modifier)
                if not modifier then; modifier = 1; end
                initLength = initLength + modifier
            end},

        near = {
            id = "lengthUP",
            down = "lengthSET",
            right = "confirm"
        }
    })

    ui.define({
        id = "lengthSET",

        pos = {5,7}, 
        replaceable = true,
        action = function()
            --get number from user
            local newNum = nil
            repeat
            if newNum == nil then
                ui.draw("lengthSet","Input number")
            else
                ui.clear("lengthSet",12)
                ui.draw("lengthSet",newNum)
            end
            local event, char = os.pullEvent("key")
            local input = revKeys[char]
            if string.find(input,"%d") then
                newNum = newNum..input
            end
            until input == "enter" or input == "numPadEnter"
            initLength = newNum
            return initLength
        end,
         
        near = {
            id = "lengthSET",
            up = "lengthUP",
            down = "lengthDOWN",
            right = "confirm"
        }
    })

    ui.define({
        id = "lengthDOWN",

        replaceable = true,
        pos = {1,termY}
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

    ui.prevMenu()
end

return {
    name = "initSetup",
    define = define,
    draw = draw,
    defaultButton = "wait"
}