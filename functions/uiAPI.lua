require("logic")

ui = {}
--sigh. okay, lets go...

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
    description = "Table of selectable buttons",
    default = {},
    type = "table"
})


function highlight(location, text)

    --if HIGH == true then
        term.setCursorLocation(location[1],location[2])
        term.setBackgroundColor(2^7)
        term.setTextColour(2^3)
        term.write(text)
        sleep(0.25)
        term.setCursorLocation(location[1],location[2])
        term.setTextColour(2^9)
        term.write(text)
    --else
        --sleep(0.25)
    --end

end

function defaultStyle(location, text)
    term.setTextColour(2^0)
    term.setBackgroundColor(2^15)
    term.setCursorLocation(location[1],location[2])
    term.write(text)
end



--settings.set("sys.storage.ui.buttons")
--require("keys")

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

--startpos = {x,y}
--id = "{"id","text"} --text = "string"
--near = {left = button, right = button ...}
--action = function()
--key = "string" for keys[string] or keys.abc
function ui.button(startPos, id, near, action, key)
    vprint(startPos)
    
    local buttonTable = settings.get("sys.storage.ui.buttons")
    local button = {
        id = id[1],
        text = id[2], 
        pos = startPos, 
        near = near}
        vprint(button)    
    if type(action) == "function" then
        button.action = action
    elseif action then
        button.action = action[1]
        button.args = action[2]
    end
    

    buttonTable[id[1]] = button
    vprint("Saving button table, added "..id[1])
    vprint(textutils.serialize(buttonTable))
    settings.set("sys.storage.ui.buttons",buttonTable)

    --else if key do function on that key press??
    if not id[2] then; id[2] = id[1]; end

    term.setCursorPos(startPos[1],startPos[2])
    term.write(id[2])
    local endPos = startPos[1] + #id[2]
    
    vprint(endPos)
    return endPos
end

function ui.selector(selectButton)

    if selectButton then
        settings.set("sys.storage.ui.selected", selectButton)
    else
        selectButton = settings.get("sys.storage.ui.selected")
    end

    local buttonTable = settings.get("sys.storage.ui.buttons")
    vprint(buttonTable)
    vprint(textutils.serialise(buttonTable))
    local buttonData = buttonTable[selectButton]
    local nearButtons = settings.get("sys.storage.ui.adjacent")

    parallel.waitForAny(
    function()
        local event, input, held = os.pullEvent("key")
        if input == keys.enter or input == keys.numPadEnter then
            settings.set("sys.storage.ui.selected", nil)
            buttonTable[selectButton].action()

        elseif (input == keys.w or input == keys.up) and nearButtons.up then
            settings.set("sys.storage.ui.selected", nearButtons.up)

        elseif (input == keys.s or input == keys.down) and nearButtons.down then
            settings.set("sys.storage.ui.selected", nearButtons.down)

        elseif (input == keys.a or input == keys.left) and nearButtons.left then
            settings.set("sys.storage.ui.selected", nearButtons.left)

        elseif (input == keys.d or input == keys.right) and nearButtons.right then
            settings.set("sys.storage.ui.selected", nearButtons.right)
        end
    end,

    function()
        local buttonData = buttonTable[selectButton]
        while true do
            highlight(buttonData.pos, buttonData.text)
        end
    end)   
end

function ui.page(name,desc,buttons)
    --Makes a 'page' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
    term.setCursorPos()
    write(name)

end

function ui.button(name, luaChunk, location, key)

    local x,y = 0
    if location then
        x,y = location.x,location.y
    elseif not settings.get("sys.ui.buttonpos") then
        settings.set("sys.ui.buttonpos",{})
    end
end


function ui.itemMenu()
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

function ui.requestMenuItem(currItem, maxCount)
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

return ui
