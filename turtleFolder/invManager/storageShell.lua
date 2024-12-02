local args = {...}
modem = peripheral.wrap("modem")
if modem then modem.open(220) end

require("storageHall")

if args[1] == "scan" then
    inspectStorage()
end

settings.define("sys.storage.ui.selected", {
    description = "Currently highlighted button",
    type = "string"
})
settings.define("sys.storage.ui.adjacent", {
    description = "The buttons above, below, left and right of the highlighted button",
    default = {up = nil, down = nil, left = nil, right = nil},
    type = "table"
})

settings.define("sys.storage.ui.buttons",{
    description = "Table of selectable buttons"
})

settings.define("sys.storage.ui.keyindex")

require("keys")


while true do

   

    --HOW DO I WANT TO DO THIS AHGHGASGHADGAWE
    --i am SO annoying why am i writing this an not just MAKING up my MIND UGH

    --sigh.
    --this will probably stay on pause for a very, long time.
    --Mostly because im not sure what i want to do, and im not sure
    --how to do most of my ideas, and some of em i just dont want to
    --use other's library code, for ... some reason.
--[[
    while true do
    event, side, channel, rplyChannel, input, distance = os.pullEvent()
     
        if event == "modem_message" and rplyChannel == 221 then
            --Stuff from wireless to do

        elseif event == "key" then
            --
            if keys.r then

            end
        end
    end
    
    --string.gsub(input, " ", "")
    while input do --??
    
    input, replacements = string.gsub(input,"request ","",1)
    print(replacements)
    if replacements == 1 then
        --Handle a request
    end


    end
    ]]

    --SCREW IT
    
    term.setCursorPos(1,1)

    write("Welcome! What would you like to do?\n")
    write("request items; scan inventory; re-init; help\n")

    ui.button({5,5},"request",itemMenu())
    
    --| scan | init | help")

end

function itemMenu()
    local itemList, nameList = require("storageData/total")
        --Complete item list of what we own.
    local x, maxPosition = term.getSize()
        --The range of the screen
    local selectedPosition = 1
        --Selected vertical position
    local indexPosition = 1
        --Current position in the list
        --(Technically, the index position is at the top of the screen)

    term.clear()
    --ui.draw("tableMenu", itemList)

    --this will probably end badly but what if i load the entire list first?
    --Then use term.scroll?
    while true do

        --take input
        


        if selectedPosition < 5 then
            --top of screen
            if 1 > indexPosition - 10 then
                indexPosition = 1
            else
                indexPosition = indexPosition - 10
            end
        
        elseif selectedPosition > maxPosition-5 then
            --Bottom of screen
            if indexPosition + 10 > #itemList then
                indexPosition = 1
            else
                indexPosition = indexPosition + 10
            end
        end

        --ui.drawRequestMenu()--?
        for i = indexPosition,maxPosition do
            local next = ui.button({1,i}, nameList[i], itemList[nameList[i].count], {requestMenuItem, nameList[i], itemList[nameList[i]].count})
            ui.button({next,i}, nameList[i].."Count", itemList[nameList[i]].count)
        end
        

    end
end

function requestMenuItem(currItem, maxCount)
    --Highlight the amount that is going to be requested.
    --Show the total amount you have.
    -- use + and - or left and right arrows to change request amount
    --shift for 64 per click, ctrl for 32, alt for 16

    local multiplier = 1
    local itemCount = 1


    if input == keys.leftAlt or input == keys.rightAlt then
        multiplier = 16
    elseif input == keys.leftCtrl or input == keys.rightCtrl then
        multiplier = 32
    elseif input == keys.leftShift or input == keys.rightShift then
        multiplier = 64
    end
    
    if input == keys.minus or input == keys.left then
        if itemCount > 1 then
            itemCount = itemCount - 1
        end
    elseif  input == keys.equals or keys.right then
        if itemCount < maxCount then
            itemCount = itemCount + 1
        end
    elseif input == keys.enter or input == keys.numPadEnter or input == keys.space then
        request(currItem,count)
    end
    

end


function ui.center(middle, text, right)

    local median = table.length(text)

    if type(middle) == table then
        middle = middle[1]
    end
    --to find the start location...
    --i need to go half text to the left of the midpoint
        middle = middle - median/2

    if middle < 1 then 
        return false, "text too big"
    else
        return middle
    end

    
end

function ui.button(startPos, id, text, action, key)
    
    if key == "select" then
        local buttonTable = settings.get("sys.storage.ui.buttons")
        button = {id = id, pos = startPos, action = action[1], args = action[2]}
        table.insert(buttonTable, id)
        settings.set("sys.storage.ui.buttons",buttonTable)
    end
    --else if key do function on that key press??
    if not text then; text = id; end

    term.clearLine()
    term.setCursorPos(startPos[1],startPos[2])
    term.write(text)
    endPos = startPos + #text

    return endPos
end
--[[
function ui.selector()
    
    event, key, held = os.pullEvent("key")
    if key == keys.enter or key == keys.numPadEnter then
        local buttonTable = nil
    end
end

function ui.split(startPos, name, data, action)
    
end]]