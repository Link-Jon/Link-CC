require("logic")
local inv = require("inventoryAPI")
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

local ui = {style = {}}
--sigh. okay, lets go...

settings.define("sys.storage.ui.selected", {
    description = "Currently highlighted button(s)",
})--this probably wont be used much except as a backup


posData = {}
textData = {}
buttonData = {}
currPos = {1,1}


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



style ={
    default = {colours.white, colours.black},
    highlight = {colours.yellow, colours.black},
    blink = {colours.orange, colours.blue},
    button = {colours.brown, colours.black},
    seperator = {colours.lightGrey, colours.black},
    list = {colours.cyan, colours.black}
}

function ui.setStyle(styleset)
    term.setTextColour(styleset[1])
    term.setBackgroundColour(styleset[2])
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
    --If given position data..
    if id.pos then

        if posData[textID] then
            vprint("Warning, redefining posID: "..textID)
            posData[textID] = id.pos
        else
            posData[textID] = id.pos
        end
        --theres probably a better way to do this
        --but for now.. just add it to table.
        --posData[textID] = table.append(posData[textID], id.pos)
        
        if not next then; next = id.pos[1]; end --Prep for next
    end

    --If given text data...
    if id.text then

        if textData[textID] then
            vprint("Warning, redefining textID: "..textID)
        end

        textData[textID] = {text = id.text}
        if id.style then; textData[textID].style = id.style; end
    end

    if id.near or id.action then

        if buttonData[textID] then
            vprint("Warning, redefining buttonID: "..textID)
        end
        if not id.style then; id.style = "button"; end --Set Style
        buttonData[textID] = {id = textID}

        if not id.near then --Enforce id.near
            buttonData[textID].near = {id = textID} 
            vprint(textID.." has no id.near!")
        else
            buttonData[textID].near = id.near
        end
        
        if type(id.action) == "function" then --Enforce id.action
            buttonData[textID].action = id.action
        elseif id.action == nil then
            id.action = function(); print("Button not setup"); sleep(1); end
        else
            error(textID.." button's action is not a function, but also not nil")
        end

    end

    --give end location
    if id.text and next then; 
        next = next+#id.text; 
    end
    return next
end


--------ui.draw--------
--id = text id
--location = {x,y} or location = "pos name"
function ui.draw(textID, location, drawBool)

    if drawBool == false then
        return false
    end
    local id = {text = textData[textID], pos = posData[textID], button = buttonData[textID]}
    selected = settings.get("sys.storage.ui.selected")

    local currStyle = "default"

    if selected.id == textID then
        currStyle = "blink"
    elseif selected.right == textID or selected.left == textID or selected.down == textID or selected.up == textID then
        currStyle = "highlight"
    elseif currStyle == "default" and id.text.style then
        currStyle = id.text.style
    end

    local pos = id.pos
    if type(location) == "string" then
        pos = posData[location]
    elseif type(location) == "table" then
        pos = location
    end


    --why do you not work.
    --please. pleeeeeaaasssssse
    --wonder if i should... 'remake' this...
    --... so that everything is more organized...
    --probably.
    if location == nil then; location = "nil"; end
    if type(pos) == "table" then; pos = textutils.serialise(pos); end
    ui.write(pos.." = pos || location = "..location)
    sleep(1)
    ui.write(" || id = "..textID)
    sleep(1)
    ui.setStyle(style[currStyle])
    term.setCursorPos(pos[1], pos[2])
    term.write(id.text.text)
    ui.setStyle(style.default)
    local next = pos[1] + #id.text.text
    return next

end

function ui.write(string)
    local x,y = term.getCursorPos()
    term.setCursorPos(1,13)
    term.write(string)
    term.setCursorPos(x,y)
end

--[[
function ui.define.page(name,desc,text,buttons)
    --Makes a 'page' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
end

function ui.draw.page(name, redraw)

end]]

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

function ui.menuSelect(menuID)

    local menu = settings.get("sys.storage.ui.menu")

    if menu == "main" then
        return mainMenu
    elseif menu == "requestMenu" then
        return ui.itemMenu
    end

end

--startpos = {x,y}
--id = "{"id","text"} --text = "string"
--near = {left = button, right = button ...}
--action = function()
--key = "string" for keys[string] or keys.abc


function ui.selector(buttonID)

    menu = ui.menuSelect()
    
    if buttonID ~= nil and buttonID ~= "none" then
        selectedButton = buttonID
        settings.set("sys.storage.ui.selected", buttonData[buttonID].near)
    elseif selectedButton then
        buttonID = selectedButton
    elseif buttonID == "wait" then
        return false, "waiting"
    else
        buttonID = settings.get("sys.storage.ui.selected")
        if buttonID == "nil" then
            printError("Button id is 'none', im probably dead; ui.selector")
        --else
        --    settings.set("sys.storage.ui.selected", [buttonID])
        end
    end

    if type(buttonID) == "table" then
        buttonID = buttonID.id
    end
    local currButton = buttonData[buttonID]
    local near = currButton.near

    --parallel.waitForAny(
    --input handler
    --function()
    --while true do
    local event, input, held = os.pullEvent("key")
    
    if input == keys.enter or input == keys.numPadEnter then
        --settings.set("sys.storage.ui.selected", "none")
        currButton.action()
        --or,draw.page...

    elseif (input == keys.w or input == keys.up) and near.up ~= nil then
        selectedButton = near.up
        buttonID = near.up
        currButton = buttonData[buttonID]
        near = buttonData[buttonID].near
        settings.set("sys.storage.ui.selected", near)
        

    elseif (input == keys.s or input == keys.down) and near.down ~= nil then
        selectedButton = near.down
        buttonID = near.down
        currButton = buttonData[buttonID]
        near = buttonData[buttonID].near
        settings.set("sys.storage.ui.selected", near)
        

    elseif (input == keys.a or input == keys.left) and near.left ~= nil then
        selectedButton = near.left
        buttonID = near.left
        currButton = buttonData[buttonID]
        near = buttonData[buttonID].near
        settings.set("sys.storage.ui.selected", near)
        

    elseif (input == keys.d or input == keys.right) and near.right ~= nil then
        selectedButton = near.right
        buttonID = near.right
        currButton = buttonData[buttonID]
        near = buttonData[buttonID].near
        settings.set("sys.storage.ui.selected", near)
        

    elseif input == keys.backspace then
        local currMenu = settings.get("sys.storage.ui.menu")
        if currMenu == "main" then
            return "exit"
        end
    end


    --else backspace and a previous menu?
    --end
    --end,

    --coolhighlighter
    --ui.highlightSelected()
    --)
    sleep(0.2)
end


function ui.itemMenu()
    settings.set("sys.storage.ui.menu", "requestList")
    local itemData = require("storageData/total")
    local scrollDist = 10
        --How many lines to scroll each tiem we scroll
    local itemList = itemData[1]
    local nameList = itemData[2]
        --Complete item list of what we own.
    local termX, termY = term.getSize()
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

    --hm. can i define the list, then use
    --another for loop to draw 'chunks' of it..? 
    --I should be able to... we shall see.
    local hsync = 1
    local vsync = 1
    ui.write("Loading menu...")
    for i = 1,#nameList do
        ui.write("Loading menu... %"..((i/#nameList)))
        --name button
        local near = {index = i, id = nameList[i], up = nameList[i-1], down = nameList[i+1]}

        if near.up == nil then
            near.up = itemList[nameList[i]]
        elseif near.down == nil then
            near.down = itemList[nameList[i]]
        end

        --dunno how i want to be doing this...
        ui.define({
            id = nameList[i],
            text = string.gsub(nameList[i],"%a+:",""),
            near = near,
            action = function()
                    requestMenuItem(near.id)
                    end})
        
        ui.define({
            id = nameList[i].."count",
            text = tostring(itemList[nameList[i]].count)})

        if termY <= i then
            ui.define({
                id = "countPos"..i,
                pos = {1, i}
            })
            ui.define({
                id = "itemPos"..i,
                pos = {7, i}
            })
        end
        --itemcount button
        
        --next = ui.define({
        --    id = nameList[i].."max", 
        --    text = itemList[nameList[i]].count})
        
        --Chests // Stacks
        --ui.define.button
    end

    settings.set("sys.storage.ui.selected", buttonData[nameList[1]].near)
    sleep() --avoid 'too long without yeild'

    local first = true
    while true do

        local near = settings.get("sys.storage.ui.selected")
        selectedPosition = near.index
        local screenChanged = false
        if first == false then
            
            if selectedPosition < 5 and indexPosition > 1 then
                --top of screen
                screenChanged = true
                if 1 >= indexPosition - scrollDist then
                    indexPosition = 1
                else
                    indexPosition = indexPosition - scrollDist
                end
            
            elseif selectedPosition >= termY-5 and termY ~= #itemList then
                --Bottom of screen
                screenChanged = true
                if indexPosition + scrollDist >= #itemList then
                    indexPosition = #itemList+termY
                else
                    indexPosition = indexPosition + scrollDist  
                end
            end
        else
            first = false
            screenChanged = true
        end

        if screenChanged then
            --Draw list

            for i = indexPosition,(indexPosition+termY) do
                ui.draw(nameList[i].."count", "countPos"..i)
                ui.draw(nameList[i], "itemPos"..i)
                
                vsync = vsync + 1
                hsync = 1
            end
        end

        if nameList then
            ui.draw(nameList[near.index].."count", "countPos"..near.index)
            ui.draw(nameList[near.index], "itemPos"..near.index)

            ui.draw(nameList[near.index+1].."count", "countPos"..near.index+1)
            ui.draw(nameList[near.index+1], "itemPos"..near.index+1)

            ui.draw(nameList[near.index+2].."count", "countPos"..near.index+2)
            ui.draw(nameList[near.index+2], "itemPos"..near.index+2)

            ui.draw(nameList[near.index-1].."count", "countPos"..near.index-1)
            ui.draw(nameList[near.index-1], "itemPos"..near.index-1)

            ui.draw(nameList[near.index-2].."count", "countPos"..near.index-2)
            ui.draw(nameList[near.index-2], "itemPos"..near.index-2)
        end

        ui.selector()
 
    end
end

function ui.requestMenuItem(currItem, maxCount)
    --Highlight the amount that is going to be requested.
    --Show the total amount you have.
    -- use + and - or left and right arrows to change request amount
    --shift for 64 per click, ctrl for 32, alt for 16
    local item_picker = window.create(term.current(),29,1,39,13)
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
