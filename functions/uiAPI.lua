require("logic")

revKeys = {}
for key,value in pairs(keys) do
    revKeys[value] = key
end

local ui = {
    style = {},
    define = {},
    draw = {}
}
--sigh. okay, lets go...

settings.define("sys.storage.ui.selected", {
    description = "Currently highlighted button",
    type = "string"
})--this probably wont be used much except as a backup

allText = {}
allButtons = {}
reusableText = {}
textStyle = "default"

function ui.test()
    term.clear()
    ui.style.button()
    print("Button looks like this")
    ui.style.highlight()
    print("Highlight looks like this")
    ui.style.blink()
    print("Highlight flash looks like this")
    ui.style.default()
    print("Default")
    sleep(2)
    --io.read()
end

function ui.style.highlight(location, text, noblink)
    
    --term.setCursorPos(location[1],location[2])
    --term.setBackgroundColor(colours.black)
    term.setBackgroundColor(colours.black)
    term.setTextColour(colours.yellow)
    textStyle = "highlight"
    --term.write(text)
    --ui.defaultStyle()
    
end

function ui.style.blink()
    --term.setCursorPos(location[1],location[2])
    term.setBackgroundColor(colours.lightBlue)
    term.setTextColour(colours.orange)
    textStyle = "blink"
    --term.write(text)
end

function ui.style.button()
    term.setTextColour(colours.brown)
    term.setBackgroundColor(colours.black)
    textStyle = "button"
    --[[if location then
        term.setCursorPos(location[1],location[2])
        term.write(text)
        ui.defaultStyle()
    end--]]
end

function ui.style.default(location, text)
    term.setTextColour(colours.white)
    term.setBackgroundColor(colours.black)
    textStyle = "default"
    --[[
    if location then
        term.setCursorPos(location[1],location[2])
        term.write(text)
    end]]
end

function ui.define.text(location, text, id, style)

    if not text then
        text = id
    end
    allText[id] = {location = location, id = id, text = text}
    local endPos = location[1] + #text
    return endPos, id
end

function ui.draw.text(id, location)

    local text = allText[id]
    
    if location then
       text.location = location 
    end
    ui.style.default()
    term.setCursorPos(text.location[1],text.location[2])
    term.write(text.text)

    ui.style.default()

    local endPos = text.location[1] + #text
    return endPos
end

function ui.define.reusable(id, text, posList, nextInput)
    
    if reusableText[id] then
        id = reusableText[id]
        --if theres more positions to add to the list, do it now
        if posList then
            for key,value in pairs(posList) do
                if id["posList"][key] ~= nil then
                    printError("id = "..id.."; key = "..key.."; Saved Value = "..id["posList"][key])
                    error("location reusableText[id][key] is not nil!")
                end

                id["posList"][key] = value
            end
        end

        --all the below must be done after defining new positions, 
        --as we may (probably) be trying to call them

        --Text is already defined, we can instead use this to be a nicer way of using
        --'nextInput'
        if text ~= nil then
            nextInput = text
        end
        
        --uses 'nextInput' to return a 'next' value like the other
        --text define/draw functions...
        if nextInput then
            next = id["posList"][nextInput][1]
            next = next+#id.text
        end

        return next
    else
        reusableText[id] = {
            id = id,
            text = text,
            posList = posList
        }
        if nextInput then
            id = reusableText[id]
            next = id["posList"][nextInput][1]
        next = next+#id.text
        end
        return next, id
        
    end
end

function ui.draw.reusable(id, location)
    local text = reusableText[id]
    local loc = text.posList[location]

    term.setCursorPos(loc[1],loc[2])
    term.write(text.text)

    local endPos = loc[1] + #text
    return endPos
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
function ui.define.button(startPos, text, near, action, key)
    

    term.clear()
    term.setCursorPos(1,1)

    local id = near.id
    if not allButtons[id] then
        allButtons[id] = {id = near.id}
        allButtons[id].text = text
        allButtons[id].pos = startPos
        allButtons[id].near = near
        if type(action) == "function" then
            allButtons[id].action = action
        elseif action == nil then
            action = function()
                        print("Button not setup")
                    end
            --[[
            ui.define.text(startPos,id,text)
            allButtons[id] = nil
            return endPos,id, "text"
            vprint("No valid function defined for button "..id)
            vprint("Probably fine in a dev environment.")
            vprint("Garrenteed bug if it is not, open an issue if so.")

            vprint("...also you've no idea how much time i made myself waste")
            vprint("by redefining non-function buttons to text...")
        else
            print(type(action))
            error("Action must be a single function or nil")
            do something like...
            function(); return function(with, args); end
        ]]
        end

        local endPos = startPos[1] + #text
        return endPos, id
    else
        vprint("Attempted to redefine button "..id)
        return 0, "false"
    end
    --else if key do function on that key press?

end

function ui.draw.button(buttonID, selected)
    
    selected = settings.get("sys.storage.ui.selected")
    if selected == buttonID then
        selected = true
    else
        selected = false
    end
    local text = allButtons[buttonID].text
    local startPos = allButtons[buttonID].pos

    if selected then
        currStyle = "blink"
    elseif nearSelected then
        currStyle = "highlight"
    else
        currStyle = "button"
    end

    ui.style[currStyle]()
    term.setCursorPos(startPos[1],startPos[2])
    term.write(text)
    ui.style.default()
    local endPos = startPos[1] + #text
    return endPos

end

function ui.selector(buttonID, selectCoroutine)
    --should probably be run explicitly as a coroutine
    
    if buttonID ~= nil and buttonID ~= "none" then
        selectedButton = buttonID
        settings.set("sys.storage.ui.selected", buttonID)
    elseif selectedButton then
        buttonID = selectedButton
    else
        buttonID = settings.get("sys.storage.ui.selected")
        if buttonID == "none" then
            printError("Button id is 'none', im probably dead; ui.selector")
        else
            settings.set("sys.storage.ui.selected", buttonID)
        end
    end

    
    local buttonData = allButtons[buttonID]
    local nearButtons = buttonData.near
    term.setCursorPos(1,13)
    write(buttonID)

    --parallel.waitForAny(

    --input handler
    --function()
    --while true do
    local event, input, held = os.pullEvent("key")
    
    if input == keys.enter or input == keys.numPadEnter then
        --settings.set("sys.storage.ui.selected", "none")
        buttonData.action()
        term.clear()
        mainMenu("all")
        --or,draw.page...

    elseif (input == keys.w or input == keys.up) and nearButtons.up ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.up)
        selectedButton = nearButtons.up
        buttonID = nearButtons.up
        buttonData = allButtons[buttonID]
        nearButtons = allButtons[buttonID].near

    elseif (input == keys.s or input == keys.down) and nearButtons.down ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.down)
        selectedButton = nearButtons.down
        buttonID = nearButtons.down
        buttonData = allButtons[buttonID]
        nearButtons = allButtons[buttonID].near

    elseif (input == keys.a or input == keys.left) and nearButtons.left ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.left)
        selectedButton = nearButtons.left
        buttonID = nearButtons.left
        buttonData = allButtons[buttonID]
        nearButtons = allButtons[buttonID].near

    elseif (input == keys.d or input == keys.right) and nearButtons.right ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.right)
        selectedButton = nearButtons.right
        buttonID = nearButtons.right
        buttonData = allButtons[buttonID]
        nearButtons = allButtons[buttonID].near

    elseif input == keys.backspace then
        local currMenu = settings.get("sys.storage.ui.menu")
        if currMenu then
            return "exit"
        end
    end
    mainMenu({button = true})
    --else backspace and a previous menu?
    --end
    --end,

    --coolhighlighter
    --ui.highlightSelected()
    --)
    sleep(0.2)
end

--[[
function ui.highlightSelected(buttonID)

        if not buttonID then
            buttonID = settings.get("sys.storage.ui.selected")
            sleep(0.5)
        elseif buttonID ~= "none" then
            buttonData = allButtons[buttonID]
            
            
            ui.style.highlight()
            term.setCursorPos(buttonData.pos[1],buttonData.pos[2])
            term.write(buttonData.text)
            
            sleep(0.5)
            
            ui.style.blink()
            term.setCursorPos(buttonData.pos[1],buttonData.pos[2])
            term.write(buttonData.text)
            ui.style.default()
            sleep(0.5)
        else
            sleep(1)
        end

end]]



function ui.define.page(name,desc,text,buttons)
    --Makes a 'page' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
end

function ui.draw.page(name, redraw)

end

function ui.itemMenu()
    local itemData = require("storageData/total")
    local itemList = itemData[1]
    local nameList = itemData[2]
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
        
        local screenChanged = false

        if selectedPosition < 5 then
            --top of screen
            screenChanged = true
            if 1 > indexPosition - 10 then
                indexPosition = 1
            else
                indexPosition = indexPosition - 10
            end
        
        elseif selectedPosition > maxPosition-5 then
            --Bottom of screen
            screenChanged = true
            if indexPosition + 10 > #itemList then
                indexPosition = 1
            else
                indexPosition = indexPosition + 10
            end
        end

        --ui.drawRequestMenu()--?
        --maybe that idea of defining a preserved location,
        --and being able to put whatever text whenever was a great idea...
        for i = indexPosition,maxPosition do
            --name button
            if maxPosition == i+1 or maxPosition == i then
                down = nil
                up = nameList[i+1]
            elseif indexPosition == i-1 or indexPosition == i then
                up = nil
                down = nameList[i-1]
            else
                up = nameList[i+1]
                down = nameList[i-1]
            end

            local next = ui.define.button({1,i}, nameList[i], itemList[nameList[i].count], {requestMenuItem, nameList[i], itemList[nameList[i]].count})
            
            --itemcount button
            next = ui.define.button({next,i}, nameList[i].."Count", itemList[nameList[i]].count)
            
            --Chests // Stacks
            --ui.define.button
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
