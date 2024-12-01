--Todo
--I bet theres more to be added here, but I dont yet know what

require("moveAPI")

function scan(side)

    --local lookback = look(side)
    --wait right i dont need to look at ALL.

    local chest = peripheral.wrap(side)

    if chest == nil or not type(chest) == "table" or not chest.size then; 
        return {name = "void"}, {count = -1} 
    end;

    local itemData = chest.list()
    local chestData = {}
    for i = 1,chest.size() do
        chestData[i] = {name="",count=-1}
        if not itemData[i] then
            chestData[i].name = "empty"
            chestData[i].count = 0
        else
            chestData[i].name = itemData[i].name
            chestData[i].count = itemData[i].count
        end
    end

    return chestData, itemData
end

function search(item, inventory)
    if inventory == turtle then
        oldSlot = turtle.getSelectedSlot()
        for i = 1,16 do
            turtle.select(i)
            if turtle.getItemDetail().name == item then
                return i
            end
        end
    
    end--else
        
    --inventory.getItem()

end


function mergeItemData(itemData)
    --merge a table of itemData, recieved from scan()

    term.clear()
    term.setCursorPos(1,1)
    print("Merging Item Data, this may take a moment")
    local totalItems = {}
    term.setCursorPos(10,8) --10 over, 8 down
    term.write(0)

    for chests = 1,#itemData do
        term.setCursorPos(10,8)
        term.clearLine()
        local chestPercent = chests/#itemData*100
        term.write(chestPercent.."% chests")
        
        for slots = 1,#itemData[chests] do
        
            term.setCursorPos(10, 10)
            term.clearLine()
            local slotPercent = slots/#itemData[chests]*100
            term.write(slotPercent.."% slots")
    
            local name = itemData[chests][slots].name
            local count = itemData[chests][slots].count

            if totalItems[name] == nil then
                totalItems[name] = count
            else
                totalItems[name] = totalItems[name] + count
            end
            
        end
    end

    return totalItems
end
