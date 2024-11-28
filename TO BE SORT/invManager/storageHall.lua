require("logic")

--on the first run we need to find out
--how long the hall is.
--the hall should be either one sided,
--or a 1 block gap between sides (chests)

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
    if trapped then; block = 2; else block = 1; end


    if detectMethod[1] == "block" then
        print([[Please replace the block at both ends of the hallway with a different block.
        It can be anything, it simply helps the turtle stay in bounds.
        The turtle will use the block id of the block underneath itself,
        Note, this setup probably wont work if the turtle isnt curerntly
        Feel free to restart this program if you need to.
        Yes = Continue, No = quit (Default Yes | Y/N)]]
        write(">")
        readjust = tonumber(io.read())
        
        if readjust = "no" or readjust = "n" or readjust = "f" or readjust = "false" then
            print("Quitting...")
        end
    elseif

    
    --3|5wide only 1 tall. chests on both sides
    if shape = "hall" then

end
