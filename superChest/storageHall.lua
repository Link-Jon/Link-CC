--Todo
--I dont think this is feature functional yet,
--So, that is the goal here. Finish.

--ok. So. This will require for the turtle to be ONLY used for this.
--Caaannot be used for other things...

--Features needed:
--Scan the storage area, store the data to a file
--At any time, even while scanning, accept an item request
--Every item request should be as follows:
--itemNames, Array or string (will be converted to array), contains item ID(s) to collect.
--itemNames = {"modname:block_id","modname:item_id","ect"}
--itemCount, Array or number (will be converted to array), how many of itemNames[i] to collect.
--itemCount = {1, 64, 10}

--The turtle *should* be taking from the closest chests, but this will probably be done later
    --cant you just start searching the array from your location?
    --shift the array so your location is '0', and then you can count once, and
    --flip it from positive to negative (with a few tweaks)
        --Do remember  x*-1 = -x

--Optionally, nameStrict = Bool. If true, then use exact item names.
--Will be more useful later, as the idea is for nonstrict requests
--to use more generic name for a particular preset of items.

--Optionally, countStrict = Bool. If true, error() if there is not enough
--of an item for the request to be fufilled

--Can probably use parallel api to look for multiple items at once.
--just remember to use waitForAll, as 'any' will quit other threads
--when one completes


--OOOKKAAAY yeah im not going to be added lama any time soon, that will take quite a while to port.
--soooo for now....
--moveapi, once again exists lol
--Alright, lets roll...

require("logic")
require("moveAPI")
require("inventoryAPI")


--on the first run we need to find out
--how long the hall is.
--the hall should be either one sided,
--or a 1 block gap between sides (chests)

--turtle really, REALLY should be are the start of the hall before
--begining init.
local storage = {}

function storage.init(detectMethod, chestLayout, trapped)

    if type(chestLayout) == "string" then
        chestLayout = {chestLayout}
    end

    local shape = "hall"
    --chestLayout = {"up", "down", "left", "right"}
        --Doesnt need them all; must have one; cannot include more

    --trapped = bool, weither or not to expect
    --chest spacing. (False = no trapped chests, chests are every other block.)
    if trapped then; trapped = 2; else trapped = 1; end

    --Settings api is a very easy way to store config data for later.
    --For easier access later, i will define all settings i change here...
    --but im probably changing them elsewhere.
    settings.define("sys.storage.step", {
        description = "Chest spacing; how far to move every time we move",
        default = 1,
        type = "number"
    })
    settings.define("sys.storage.detector",{
        description = "What detection function to call",
        type = "string"
    })
    settings.define("sys.storage.blockID", {
        description = "Block ID to not allow the turtle past",
        default = "minecraft:command_block",
        type = "string"
    })
    settings.define("sys.storage.endPos", {
        description = "Length of hall in blocks",
        default = -1,
        type = "number"
    })
    settings.define("sys.storage.startPos", {
        description = "Location of 'start' of hallway",
        default = 0,
        type = "number"
    })
    settings.define("sys.storage.currPos", {
        description = "Current location of turtle.",
        default = 0,
        type = "number"
    })
    settings.define("sys.storage.axis", {
        description = "The direction going away from the start position, 'positive x' = px, and such",
        type = "string"
    })
    settings.define("sys.storage.chestSides", {
        description = "Array, containing which sides have chests",
        default = {"left"},
        type = "table"
    })

    settings.set("sys.storage.step", trapped)
    --[[
    if errcheck(shape, "hall",{"halls", "hallway"}) then
        settings.set("sys.storage.shape","hall")
        settings.set("sys.storage.chestSides",{"left","right"})  
    elseif errcheck(shape, "plus",{"+"}) == "plus" then
        settings.set("sys.storage.shape","plus")
        settings.set("sys.storage.chestSides",{"left","right","down","up"})  
    else
        error("Invalid shape, "..shape)
    end]]
    settings.set("sys.storage.chestSides", chestLayout)

    if type(detectMethod) ~= "table" then
        detectMethod = {detectMethod}
    end



    --Prep detection
    
    if detectMethod[1] == "block" then
        --[[
        print(Please replace the block at both ends of the hallway with a different block.
        It can be anything, it simply helps the turtle stay in bounds.
        The turtle will use the block id of the block currently underneath itself)

        write("Ready? >")
        local ready = nilcheck(io.read())
        
        if ready == false then
            print("Quitting...")
            return false
        end]]

        local _, temp = turtle.inspectDown()
        settings.set("sys.storage.blockID", temp["name"])
        settings.set("sys.storage.detector","blockID")
        settings.set("sys.storage.startPos", 0)
        settings.set("sys.storage.currPos", 0)
        settings.set("sys.storage.totalLength",-1)
        --]]

    elseif detectMethod[1] == "length" then
        
        --local startpos = detectMethod[3] or 1
        local startpos = 0
        local direction = detectMethod[3]
        --untill the gps can also start in
        --arbitrary locaiton, startpos cannot

        if startpos > detectMethod[2] then
            print("Start position is larger than length, swapping sign... -1*x")
            settings.set("sys.storage.totalLength", startpos)
            startpos = detectMethod[2]*-1
        elseif detectMethod[2] == 0 then
            settings.set("sys.storage.step",0)
            settings.set("sys.storage.totalLength", detectMethod[2])
        else
            settings.set("sys.storage.totalLength",detectMethod[2])
        end
        settings.set("sys.storage.detector","totalLength")
        
        
        --[[
        initGPS(direction)
        local facing = settings.get("sys.movement.facingStr")
        if facing == "north" then
            settings.set("sys.storage.detection.axis", "z")
        elseif facing == "south" then
            settings.set("sys.storage.detection.axis", "z")
        elseif facing == "east" then
            settings.set("sys.storage.detection.axis", "x")
        elseif facing == "west" then
            settings.set("sys.storage.detection.axis", "x")
        end
        --]]
        settings.set("sys.storage.startPos", startpos)
    else
        error("Detection method: "..detectMethod[1])
    end

    settings.save()
    storage.inspect("first run")

end



function storage.checkForBounds(reverse)

    local step = settings.get("sys.storage.step")
    if step == 0 then
        --room is probably a one block space, dont move
        return false, "Step size is 0, wont move."
    end

    while step > 0 do

        local currPos = settings.get("sys.storage.currPos")
        local startPos = settings.get("sys.storage.startPos")
        local endPos = settings.get("sys.storage.endPos")
        local method = settings.get("sys.storage.detector")
        local move = "forward"
        local direction = 1

        ---[[
        print("step: "..step)
        print("currPos: "..currPos)
        print("start: "..startPos)
        print("end: "..endPos)
        print("method: "..method)
        --]]

        if method == "blockID" then
            local bool, block = turtle.inspectDown()
            if block.name == settings.get("sys.storage.blockID") and currPos > startPos then
                print("New end pos: currPos")
                settings.set("sys.storage.endPos", currPos)
                endPos = currPos
                if reverse == nil then
                    print("Movement Stopped, at end")
                    return false
                end
            end
        end


        if reverse then
            --make us go in reverse lol
            move = "back"
            direction = -1
        end

        --print("move: "..move)
        --print("direction: "..direction)

        if currPos == startPos and reverse then
            --At start, dont go back
            print("At start, dont go back")
            return false
        elseif currPos < startPos then
            --we are BEFORE the start. Bad.
            error("Currently before the start pos. Shall decide later if this error stays, or if it will move forward.")
        end

        if endPos > -1 then
            if currPos == endPos and not reverse then
                print("At end, dont pass")
                --At the end, dont continue
                return false

            elseif currPos > endPos then
                --we are AFTER the end. Bad.
                error("Currently after the end pos. Shall decide later if this error stays, or if it will move back.")
            end
        end

        --print("Check complete.")
        --io.read()

        --Those position check stuff can probably be done better with less if statements...
        --probably not with less evaluations though.


            
        if turtle[move]() then
            step = step - 1 --i think?
            currPos = currPos + direction
            print("Moved")
            settings.set("sys.storage.currPos",currPos)
        else
            print("move() failed, stopping")
            --stop trying to move??
            return false
        end
    end
end    



function storage.inspect(details)
    --Rescans entire storage, updates the current data.
    if details == "first run" then
        local chest = true
    end
    --[[
    local step = settings.get("sys.storage.step")
    if step > 1 then
        local trapCounter = trueterm.clearLine()
        local moveDist = step
    end
    ]]
    local chestSides = settings.get("sys.storage.chestSides")
    local shape = settings.get("sys.storage.shape")
    if settings.get("sys.storage.detector") == "totalLength" then
        local length = settings.get("sys.storage.endPos")
    end

    local itemData = {}

    --collect chest inventories. If no chest where there should be, 
    --and we have some, place em
    --Length detector
    
    local chestNumber = 1
    if chestSides == nil then
        error("You need to init storage first!")
    end

    while true do

        for key,chestDir in pairs(chestSides) do

            if turtle.detect() == nil then; turtle.place(); end
            chestData, itemData[chestNumber] = storage.scan(chestDir)
            if chest then; append = "ar"; else append = "w"; end

            local storageData = fs.open("storageData/chest"..chestNumber,append)
            local temp = textutils.serialize(chestData)
            storageData.write("return "..temp)
            storageData.close()
            print("Chest complete: "..chestNumber)
            chestNumber = chestNumber+1
        end

        if false == storage.checkForBounds() then; break; else; end
    end

    
    --sleep(0) ?

    
    if parallel then
        
        parallel.waitForAll(
            function()
                --merge and save data
                local combinedItems = mergeItemData(itemData)
                local serialCombinedItems = textutils.serialize(combinedItems)
                local nameList = {}
                local i = 1
                for key,value in pairs(combinedItems) do
                    nameList[i] = key
                    print(key)
                    i = i + 1
                end
                nameList = textutils.serialise(nameList)
                local temp = fs.open("storageData/total","w")
                temp.write("mainList = "..serialCombinedItems.."\n")
                temp.write("nameList = "..nameList.."\n")
                temp.write("return mainList, nameList")
                temp.close()
                print("Scan data saved.")
            end,
            function()
                --return to start of hall
                repeat
                local temp = storage.checkForBounds(true)
                until temp == false
            end
        )
    else

        local combinedItems = mergeItemData(itemData)
        combinedItems = textutils.serialize(combinedItems)
        local nameList = {}
        local i = 1
        for key,value in pairs(combinedItems) do
            nameList[i] = key
            print(key)
            i = i + 1
        end
        nameList = textutils.serialise(nameList)
        local temp = fs.open("storageData/total","w")
        temp.write("mainList = "..combinedItems.."\n")
        temp.write("nameList = "..nameList.."\n")
        temp.write("return mainList, nameList")
        temp.close()
        print("Scan data saved.")

        --return to start of hall
        repeat
        local temp = storage.checkForBounds(true)
        until temp == false
    end
end

--Everything above seems complete. mostly. shall see later.
--Time to make the storage handler.

function storage.requestItem(name, count, maxcount)

    if type(name)=="string" then
        name = {name}
    end
    if type(count)=="number" then
        count = {count}
    end

    if maxcount == nil then
        maxcount = count
    elseif type(maxcount) == "number" then
        maxcount = {maxcount}
    end

    if #name > 16 then
        error("Too many types of items requested at once")
    end

    local slots = 0
    for key, value in pairs(name) do
    --need to know what the stack size is for the item
    --then, do count/maxcount. round to ceiling, and add to slots taken...
    --do this for all items, and if slots is bigger than 16, crash.

        --This may change slightly (not functionally, though)
        --later if i change the input style to match the saved data better....
        slots = slots + (count[key]/maxcount[key])
        slots = math.ceil(slots)
        if slots > 16 then
            error("Too many items requested at once (Too big of stacks, probably)")
        end
        
    end

    --ensure request doesnt exceed turtle space limit
    --have something else handle larger requests...
    local itemList = require("storageData/total")
    for i = 1,#name do
        --name = formatItemName(name)
        local currItem = itemList[name[i]]

        if not currItem then
            print("Item not found: "..name[i])
            return false
        end

        currItem.chests = table.sort(currItem.chests)

        print(currItem.count)
        print(textutils.serialise(currItem.chests))

        local chestPerRow = #settings.get("sys.storage.chestSides")
        print(chestPerRow)

        if currItem.count < count then
            print(name[i]..": "..currItem.count)
            error("Not enough items to supply request")
        end

        for chests = 1,#currItem.chests do
            local currPos = settings.get("sys.storage.currPos")

            chestLocation = math.floor(currItem.chests[chests]/chestPerRow)

        end
    end  

end

function storage.scan(side)

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

function mergeItemData(itemData, totalItems)
    --merge a table of itemData, recieved from scan()

    --term.clear()
    --term.setCursorPos(1,1)

    print("Merging Item Data, this may take a moment")
    local totalItems = {}
    
    for chests = 1,#itemData do
        local chestPercent = chests/#itemData*100
        for slots = 1,#itemData[chests] do
            local slotPercent = slots/#itemData[chests]*100
            local name = itemData[chests][slots].name
            local count = itemData[chests][slots].count

            local chestname = "chest"..chests
            if totalItems[name] == nil then
                --if we havent seen this item before
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


function storage.reset()
    --do settings all default, yeah
        settings.set("sys.storage.blockID", nil)
        settings.set("sys.storage.detector",nil)
        settings.set("sys.storage.startPos", 0)
        settings.set("sys.storage.currPos", 0)
        settings.set("sys.storage.totalLength",-1)
        settings.set("sys.storage.chestSides", nil)
        settings.set("sys.storage.shape", nil)

end



return storage