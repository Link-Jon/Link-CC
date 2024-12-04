require("logic")

--also btw, i would like to have a
--uiEdittor, that allows someone to craft a ui 
--without much knowledge of lua or cc

--the hardest part will actually be allowing them 
--to have a menu inside of a menu... at all.
--as my current idea basically splits the screen in two
--there will be an editting toolbar that takes up
--the last three rows of the screen,
--and a button that can make the toolbar switch to the top
--(or come back down)
--toolbar actually does the editting to the selected element


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


posData = {}
textData = {}
buttonData = {}

--i need a real format for saving data.
--[[
scrData = {
    pos = {
        id = {pos,data}
    }
    text = {
        id = {textdata}
    }
}

]]

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


--===================--
-----Text handlers-----
--===================--

--Oh great.
--My old code is annoying me so bad, i made these seperators, and
--Iam about to unify ALL my ui.define and ui.draw functions.
--Once again i say, i am the most annoying person i know lol


-------ui.define-------
--[[
id = {
    id = "stringID",

    pos = {x, y} or "pos name" or {name = {x,y}, name1 = {x1,y1}, ect}
    
    text = "string"
    style = "style format"

    action = function()
    near = {up = nil, down = nil, left = nil, right = nil}
    }

]]

--next = {x,y} or "pos name"
function ui.define(id, next)

    local textID = id.id

    if scrData[id] then
        vprint("Warning, redefining textID: "..textID)
    end

    --If given position data..
    if id.pos then
        if not posData[textID] then
            posData[textID] = id.pos
        else
            
                --printError("Error saving "..value)
            --printError("id = "..id.."; key = "..key.."; Saved Value = "..scrData.pos[textID][key])
            --error("location scrData[id][key] is not nil!")

            -- FIND A WAY TO SAVE MULTIPLE POSITIONS AT A TIME
            posData[textID] = id.pos            
        end

        if not next then; next = id.pos[1]; end --Prep for next
    end

    --If given text data...
    if id.text then
        if not id.style then ; 
            id.style = "default"; 
        end --Set Style

        textData[textID] = {text = id.text, style = id.style}
    end

    if id.near or id.action then
        if not id.style then; id.style = "button"; end --Set Style
        buttonData[textID] = {id = textID,}

        if not id.near then --Enforce id.near
            id.near = {id = textID} 
            vprint(textID.." has no id.near!")
        end

        if type(action) == "function" then --Enforce id.action
            buttonData[textID].action = action
        elseif action == nil then
            action = function(); print("Button not setup"); sleep(1); end
        else
            error(textID.." button's action is not a function, but also not nil")
        end

    end

    --give end location
    if id.text then; next = next+#id.text; end
    return next
end


--------ui.draw--------
--id = text id
--location = {x,y} or location = "pos name"
function ui.draw(textID, location)

    local id = scrData[textID]

    if id.type == "text" then
        ui.style.default()
        term.setCursorPos(id.location[1],id.location[2])
        term.write(id.text)

        ui.style.default()

        local endPos = id.location[1] + #id
        return endPos


    --id = text id
    --location = "location name"
    --function ui.draw.reusable(id, location)
    elseif id.type == "raw" then
        local text = scrData.raw[textID]
        
        local loc = location
        if type(location) == "string" then
            loc = scrData.pos[location]
        end

        term.setCursorPos(loc[1],loc[2])
        term.write(id.text)

        local endPos = loc[1] + #text
        return endPos


    --function ui.draw.button(buttonID, selected)
    elseif id.type == "button" then
        buttonID = id.id
        selected = settings.get("sys.storage.ui.selected")

        if selected == buttonID then
            currStyle = "blink"
        else
            currStyle = false
        end

        local text = scrData[buttonID].text
        local startPos = scrData[buttonID].pos

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
end



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

--===================--
---End text handlers---
--===================--

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

    
    local buttonData = scrData[buttonID]
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
        buttonData = scrData[buttonID]
        nearButtons = scrData[buttonID].near

    elseif (input == keys.s or input == keys.down) and nearButtons.down ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.down)
        selectedButton = nearButtons.down
        buttonID = nearButtons.down
        buttonData = scrData[buttonID]
        nearButtons = scrData[buttonID].near

    elseif (input == keys.a or input == keys.left) and nearButtons.left ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.left)
        selectedButton = nearButtons.left
        buttonID = nearButtons.left
        buttonData = scrData[buttonID]
        nearButtons = scrData[buttonID].near

    elseif (input == keys.d or input == keys.right) and nearButtons.right ~= nil then
        settings.set("sys.storage.ui.selected", nearButtons.right)
        selectedButton = nearButtons.right
        buttonID = nearButtons.right
        buttonData = scrData[buttonID]
        nearButtons = scrData[buttonID].near

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
            buttonData = scrData[buttonID]
            
            
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

            local id = {id = itemList[nameList[i]], up = itemList[nameList[i+1]], down = itemList[nameList[i-1]]}

            if id.up == nil then
                id.up = itemList[nameList[i]]
            elseif id.down == nil then
                id.down = itemList[nameList[i]]
            end

            --dunno how i want to be doing this...
            local next = ui.define.button({1,i}, nameList[i], {}, {requestMenuItem, nameList[i], itemList[nameList[i]].count})
            
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
