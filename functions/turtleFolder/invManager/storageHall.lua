require("logic")

--on the first run we need to find out
--how long the hall is.
--the hall should be either one sided,
--or a 1 block gap between sides (chests)

--turtle really, REALLY should be are the start of the hall before
--begining init.
function initStorage(shape, chestLayout, detectMethod, trapped)

    shape = string.lower(shape)
    chatLayout = string.lower(chestLayout)
    if shape not "hall" or shape not "halls" then
        print("Only 'hall' are supported currently.")
        print("Ask, or make it yourself if you need it")
        shape = "hall"
    end
    if type(detectMethod) ~= "array" then
        detectMethod = {detectMethod}
    end


    --trapped = bool, weither or not to expect
    --chest spacing. (False = no trapped chests, chests are every other block.)
    if trapped then; trapped = 1; else trapped = 0; end

    --Settings api is a very easy way to store config data for later.
    --For easier access later, i will define all settings i change here...
    --but im probably changing them elsewhere.
    settings.define("sys.storage.trapped", {
        description = "Chest spacing", 
        default = 0, 
        type = "number"
    })
    settings.define("sys.storage.detection.type",{
        description = "Extra error handling data, should be current 'detectMethod'", 
        default = false
    })
    settings.define("sys.storage.detection.detector",{
        description = "Detector function(), returns if we are at the edge of bounds or not", 
        default = nil, 
        type = "function"
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
    
    settings.define("sys.storage.detection.direction",{
        description = "Direction that the turtle is looking"
    })

    --Set a few of em though.
    settings.set("sys.storage.trapped", trapped)
    settings.set("sys.storage.")

    if detectMethod[1] == "block" then
        print([[Please replace the block at both ends of the hallway with a different block.
        It can be anything, it simply helps the turtle stay in bounds.
        The turtle will use the block id of the block currently underneath itself
        Either press enter, or type "n" to quit initization]])

        write(">")
        readjust = nilcheck(io.read())
        
        if readjust == false then
            print("Quitting...")
            return false
        end

        local _, temp = turtle.inspectDown()
        settings.set("sys.storage.detection.blockID", temp["name"])

        function detector()
            local bool, block turtle.inspectDown()
            if bool and block == settings.get("sys.storage.detection.blockID") then
                return true
            else
                return false
            end
        end

    elseif type(detectMethod[1]) == "length" then

        

    end
    
    --3|5wide only 1 tall. chests on both sides
    if shape == "hall" then
        settings.set("sys.storage.shape","hall")

    end


end
