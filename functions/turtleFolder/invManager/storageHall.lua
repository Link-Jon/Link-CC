require("logic")
require("moveAPI")
require("inventoryAPI")

--on the first run we need to find out
--how long the hall is.
--the hall should be either one sided,
--or a 1 block gap between sides (chests)

--turtle really, REALLY should be are the start of the hall before
--begining init.
function initStorage(shape, detectMethod, trapped)

    hijackTurtleAPI()
    --chestLayout = {"up", "down", "left", "right"}
        --Doesnt need them all; must have one; cannot include more

    if errcheck(shape, "hall",{"halls", "hallway"}) then
        settings.set("sys.storage.shape","hall")
    elseif errcheck(shape, "plus",{"+"}) == "plus" then
        settings.set("sys.storage.shape","plus")
    else
        error("Invalid shape, "..shape)
    end

    if type(detectMethod) ~= "table" then
        detectMethod = {detectMethod}
    end



    --trapped = bool, weither or not to expect
    --chest spacing. (False = no trapped chests, chests are every other block.)
    if trapped then; trapped = 2; else trapped = 1; end

    --Settings api is a very easy way to store config data for later.
    --For easier access later, i will define all settings i change here...
    --but im probably changing them elsewhere.
    settings.define("sys.storage.trapped", {
        description = "Chest spacing",
        default = 1,
        type = "number"
    })
    settings.define("sys.storage.detection.type",{
        description = "What detection function to call",
        type = "string"
    })
    settings.define("sys.storage.detection.blockID", {
        description = "Block ID to not allow the turtle past",
        default = "minecraft:command_block",
        type = "string"
    })
    settings.define("sys.storage.detection.totalLength", {
        description = "Length of hall in blocks",
        default = -1,
        type = "number"
    })
    settings.define("sys.storage.detection.startPos", {
        description = "Location of 'start' of hallway",
        type = "number"
    })
    settings.define("sys.storage.detection.axis", {
        description = "The direction going away from the start position, 'positive x' = px, and such",
        type = "string"
    })
    settings.define("sys.storage.chestSides", {
        description = "Array, containing which sides have chests",
        default = {"left"},
        type = "table"
    })



    --Prep detection
    if detectMethod[1] == "block" then
        print([[Please replace the block at both ends of the hallway with a different block.
        It can be anything, it simply helps the turtle stay in bounds.
        The turtle will use the block id of the block currently underneath itself]])

        write("Ready? >")
        local readjust = nilcheck(io.read())
        
        if readjust == false then
            print("Quitting...")
            return false
        end

        local _, temp = turtle.inspectDown()
        settings.set("sys.storage.detection.blockID", temp["name"])
        settings.set("sys.storage.detection.type","blockID")

    elseif type(detectMethod[1]) == "length" then

        settings.set("sys.storage.detection.type","totalLength")
        settings.set("sys.storage.detection.totalLength", detectMethod[2])
        if detectMethod[3] then
            local startpos = detectMethod[3]
        else
            local startpos = 1
        end

        local facing = settings.get("sys.movement.facingStr")
        if facing == "north" then
            settings.set("sys.storage.detection.axis", "pz")
        elseif facing == "south" then
            settings.set("sys.storage.detection.axis", "nz")
        elseif facing == "east" then
            settings.set("sys.storage.detection.axis", "px")
        elseif facing == "west" then
            settings.set("sys.storage.detection.axis", "nx")
        end

        settings.set("sys.storage.detection.startPos", startpos)
    end

    inspectStorage("first run")


end

function checkForBounds()
    method = settings.get("sys.storage.detection.detector")

    if method == "totalLength" then

        start = settings.get("sys.storage.detection.startPos")
        length = settings.get("sys.storage.detection.totalLength")
        if x == start or x == length then
            return true
        else
            return false
        end
    elseif method == "block" then
        local bool, block turtle.inspectDown()
        if block == settings.get("sys.storage.detection.blockID") then
            return true
        else
            return false
        end
    end
end

function inspectStorage(details)
    --Rescans entire storage, updates the current data.
    if first == "first run" then
        chest = true
    end

    local trapped = settings.get("sys.storage.trapped")
    if trapped > 1 then
        local trapCounter = true
        local moveDist = trapped
    end
    local chestSides = settings.get("sys.storage.chestSides")

    local shape = settings.get("sys.storage.shape")

    if shape == "hall" then
        --collect chest inventories. If no chest where there should be, 
        --and we have some, place em
        --Length detector
        
        repeat --loop start
        local chestNumber = 1
        local itemData = {}
        for key,chestDir in pairs(chestSides) do

            print(turtle)

            if turtle.detect()==false then; turtle.place(); end
            chestData, itemData[chestNumber] = scan(chestDir)
            if chest then; append = "ar"; else append = "w"; end

            local storageData = fs.open("storageData/chest"..chestNum..append)
            local temp = textutils.serialize(chestData) 
            storageData.write("return "..temp)
            storageData.close()
            chestNumber = chestNumber+1
        end

        if trapCounter then
            print("chest gap currently not implimented")
        end

        until checkForBounds()
    
    end        
        --merge itemData
        print("Merging Item Data, this may take a moment")
        for i = 1,#itemData do
            if totalItems[itemData[i].name] == nil then
                totalItems[itemData[i].name] = itemData.count
            else
                totalItems[itemData[i].name] = totalItems[itemData[i].name] + itemData
            end
        end
        


end

function activeStorage()
    --Actually does the storage stuff


end

return {
    initStorage = initStorage, 
    activeStorage = activeStorage
}