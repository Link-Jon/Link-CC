--Todo
--I bet theres more to be added here, but I dont yet know what

require("moveAPI")

function scan(side)

    --local lookback = look(side)
    --wait right i dont need to look at ALL.

    local chest = peripheral.wrap(side)

    if chest == nil or not chest.size then; 
        return {name = "void"}, {count = -1} 
    end;

    local itemData = chest.list()
    local chestData = {}
    for i = 1,chest.size() do
        if not itemData[i] then
            chestData[i].name = "empty"
            chestData[i].count = 0
        end
    end
    --UGH IM OUT OF TIME.
    --THIS IS SO GGGGGGGAAAAAAAAAAAAAA
    --I CANT FINISH THIS
    

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