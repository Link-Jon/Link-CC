--Todo
--I bet theres more to be added here, but I dont yet know what

require("moveAPI")
settings.define("sys.inv.vers", {
    description = "Inventory API Savedata version. \n(Aka, inv api version... 'savedata' is entirely redundant lol)\n Should be changed every time save table is changed.",
    type = "number"
})


local currVers = 1
settings.set("sys.inv.vers", currVers)

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


function mergeItemData(itemData, totalItems)
    --merge a table of itemData, recieved from scan()

    --term.clear()
    --term.setCursorPos(1,1)

    print("Merging Item Data, this may take a moment")
    --[[
    local dataVers = settings.get("sys.inv.vers")

    if not totalItems or totalItems.dataVers ~= dataVers then
        print("Either no previous data provided,")
        print("Or previous data is on an older version.")
        print("Starting ")
    --wait we dont need this, this is used to coalese scandata
    end
    ]]
    
    local totalItems = {}
    
    for chests = 1,#itemData do

        local chestPercent = chests/#itemData*100

        
        for slots = 1,#itemData[chests] do
            local slotPercent = slots/#itemData[chests]*100
            local name = itemData[chests][slots].name
            local count = itemData[chests][slots].count

            local chestname = "chest"..chests
            if totalItems[name] == nil then

                totalItems[name] = {
                    count = count,
                    chests = {chests}
            }
            else
                totalItems[name].count = totalItems[name].count + count
                table.insert(totalItems[name].chests, chests)
            end 
        end
    end
    --note to self, for later, 
    --ensure return variables are the right ones...
    return totalItems
end

function formatItemName()
    print("not yet made, use exact name thank")
end


return {
    formatItemName = formatItemNamem,
    mergeItemData = mergeItemData,
    search = search,
    scan = scan
}