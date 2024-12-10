local ui = require("uiAPI")

local function define()
    
    local itemList, nameList = pcall(require,"storageData/total")
    
    if itemList == false then
        term.setTextColor(colours.red)
        ui.write("You need to scan before you can request items!")
        term.setTextColor(colours.white)
        sleep(0.5)
        ui.prevMenu()
        return "redraw"
    end

        --Complete item list of what we own.
    local termX, termY = term.getSize()
        --The range of the screen

    term.clear()
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

        near.action = function() requestItem(nameList[i]) end

        --dunno how i want to be doing this...
        ui.define({
            id = nameList[i],
            text = string.gsub(nameList[i],"%a+:",""),
            button = near})
        
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
        
        --Chests // Stacks??
        --ui.define.button

        --Sorting options??
    end

    settings.set("sys.ui.selected", buttonData[nameList[1]])
end

local function draw(redraw)
    local hsync = 1
    local vsync = 1

    local itemList, nameList = pcall(require,"storageData/total")
    
    if itemList == false then
        term.setTextColor(colours.red)
        ui.write("You need to scan before you can request items!")
        term.setTextColor(colours.white)
        sleep(0.5)
        ui.prevMenu()
        return "redraw"
    end
    --Complete item list of what we own.
    local termX, termY = term.getSize()
    --The range of the screen
    local scrollDist = 10
    --How many lines to scroll each tiem we scroll
    local selectedPosition = 1
    --Selected vertical position
    local indexPosition = 1
    --Current position in the list
    --(Technically, the index position is at the top of the screen)

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


    local near = settings.get("sys.ui.selected")
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


    if screenChanged or redraw.text then
        --Draw list

        for i = indexPosition,(indexPosition+termY) do
            ui.draw(nameList[i].."count", "countPos"..i)
            ui.draw(nameList[i], "itemPos"..i)
        end
    end

    if redraw.button then
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
end

local function requestItem(currItem, maxCount)
    --Highlight the amount that is going to be requested.
    --Show the total amount you have.
    -- use + and - or left and right arrows to change request amount
    --shift for 64 per click, ctrl for 32, alt for 16

    --... lets just hijack the selector, and not use ui.selector...
    --atleast for this...

    prevTerm = term.current()
    local item_picker = window.create(term.current(),29,1,10,13)
    term.redirect(prevTerm)
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

return {
    name = "requestList",
    define = define,
    draw = draw,
    requestItem = requestItem
}