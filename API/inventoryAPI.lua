--Todo
--I bet theres more to be added here, but I dont yet know what

require("moveAPI")
settings.define("sys.inv.vers", {
    description = "Inventory API Savedata version. \n(Aka, inv api version... 'savedata' is entirely redundant lol)\n Should be changed every time save table is changed.",
    type = "number"
})


local currVers = 1
settings.set("sys.inv.vers", currVers)


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



function formatItemName(name)

    --ill probably use tables for the names later,
    --if i do end up with name overlap...
    --meh

    name = string.gsub(name,"%a+:","")
    return name
end


return {
    formatItemName = formatItemName,
    mergeItemData = mergeItemData,
    search = search,
    scan = scan
}