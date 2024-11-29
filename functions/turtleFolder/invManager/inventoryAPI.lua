require("moveAPI")

function scan(side)

    local lookback = look(side)
    local chest = peripheral.wrap(side)
    local itemData = chest.list()
    local chestData = {}
    for i = 1,chest.size() do
        if not itemData[i] then
            chestData[i].name = "empty"
            chestData[i].count = 0
        end
    end

    look(lookback)

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