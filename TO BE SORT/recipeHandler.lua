--Todo
--Make this make sense, thanks
--May need to make it usable, also

--[[
All recipes should be in the following format:

self note: {key = "value"}

NAME = modname:itemname or string.find(itemname)

recipeName = {NAME = {1, 2, 3, 4, 6, 7, 8, 9}} -- circle
Can include multiple items. Will be able to use TAGS later... hopefully

example

furnace = {"minecraft:cobblestone" = {1, 2, 3, 4, 6, 7, 8, 9,}}

turtle = {
1,  2,  3,  4
5   6,  7,  8
9,  10, 11, 12,
13  14, 15, 16
}


]]

--Because arrays in lua are indexed, starting at one,
--we can make patterns be true / false
    --... yeah im defining keys so its easier to keep track of where i am in the index
--ughhnnnhg. im not sure which is better here...
--Screw it
--circle8 = {1 = true, 2 = true, 3 = true, 4 = true, 5 = false, 6 = true, 7 = true, 8 = true, 9 = true}
--circle4 = {1 = false, 2 = true, 3 = false, 4 = true, 5 = false, 6 = true, 7 = false, 8 = true, 9 = false}

patterns = {
    circle8 = {1, 2, 3, 4, 6, 7, 8, 9},
    circle4 = {2, 4, 6, 8},
    leftCol = {1, 4, 7},
    midCol = {2, 5, 8},
    rightCol = {3, 6, 9},
    plus = {2, 4, 5, 6, 8},
    star = {1, 3, 5, 7, 9},
    corners = {1, 3, 7, 9},
    fill = {1, 2, 3, 4, 5, 6, 7, 8, 9}
}

-- Needs to be remade to use minecraft's json recipes!!
    --thats not going to happen is it....
    --actually, we should CONVERT mc's json before storing it
-- Converts from crafting table slots to turtle slots

function nameFormatter(name)
    if type(name) ~= "string" then
        return false, "bad input"
    end

    exe, exe1 = string.find(name, "%.%a+")
    if exe ~= nil then
        exe = string.sub(name, exe, exe1)
        name = string.gsub(name, "%.%a+", "")
    end

    name = string.gsub(name,":","/")
    --[[if string.find(name, "-") == false then
        print(name.."is not a valid item name!")
        return false, "bad input"
    end--]]
        return name, exe

end



function convertSlot(recipe)

    if type(recipe) ~= "array" then
        return false, "Invalid input"..type(recipe)
    end

    for iter = 1, #recipe do

    local item = recipe[iter]
        
        if item >= 4 and item <= 8 then
            item = item + 1
        elseif item >= 7  then
            item = item + 1
        end

    end
end


--i need to make the recipe maker before the lookup...
function recipeLookup(name, recipeNum)

    name = nameFormatter(name)
    if recipeNum == nil or type(recipeNum) ~= "number" then

        recipeNum = 1
        --print("recipeLookup did not receive a recipe number for "..name..". Assuming '1'")

    end

    temp = fs.open("recipelist/"..name..recipeNum, "r")
    recipe = temp.readAll()
    temp.close()

    return recipe
end



function defineRecipe(productName, recipe, recipeNum, convert, overwrite)
    
    productName, ext = nameFormatter(productName)

    if recipeNum == nil or type(recipeNum) ~= "number" then
        recipeNum = 1
    end
    
    --[[
        Needs to get a json converter.
    ]]

    if fs.exists("recipelist/"..productName..recipeNum) then
        print("function defineRecipe wishes to overwrite recipe "..productName..recipeNum)
        
        --[[
        while overwrite ~= "w" or overwrite ~= "i" or overwrite ~= "c" do
            print("Overwrite (w), Iterate until safe number (i), Cancel (c)")
            print("Will iterate if no choice made in 30 seconds")
            term.write("> ")
            overwrite = read.io()
            overwrite = string.lower(overwrite)
        end
        --if parallel
        --]]
        if overwrite == "c" then
            return false, "canceled"
        elseif overwrite == "i" or overwrite == nil then
            while fs.exists("recipelist/"..productName..recipeNum) do
                recipeNum = recipeNum + 1
            end
        end
    end

    if convert then
        convertSlot(recipe)
    end

    --Save recipe
    temp = fs.open("recipelist/"..productName..recipeNum, "w")
    print(type(recipe))
    if type(recipe) == "table" then
        recipe = textutils.serialize(recipe)
    end
    temp.write(recipe)
    temp.close()

    return true, recipeNum
end
--[[
Minecraft json recipe:

{
    "type": "minecraft:crafting_shaped"
    "pattern": [],
    "key": {},
    "result": {}
}
--]]



function jsonRecipeConvert(filename)

    meh, extender = nameFormatter(filename)
    if extender ~= ".json" and extender ~= nil then
        return false, "Not a json"
    end


    itemData = {}
    recipeData = {}
    fromFile = fs.open(filename, "r")
    fileData = fromFile.readAll()
    fileData = textutils.unserializeJSON(fileData)


    if fileData["type"] == "minecraft:crafting_shaped" then
        recipeData["craftType"] = "craftingTable"
        recipeData["shaped"] = true
    elseif fileData["type"] == "minecraft:crafting_shapeless" then
        recipeData["craftType"] = "craftingTable"
        recipeData["shaped"] = false
    else
        print("WARNING, unregistered crafting method "..fileData["type"])
        recipeData["craftType"] = fileData["type"]
        --add to log file what recipe probably has an incorrect craftType
    end


    for key,value in pairs(fileData["key"]) do
        table.insert(itemData, {key, value["item"]})
    end
    
    pattern = fileData["pattern"]
    if recipeData["shaped"] then
        --Pattern start
        patternStr = ""

        for i = 1,#pattern do
            patternStr = patternStr..pattern[i]
        end

        print("patternStr "..patternStr)
        print(patternStr[1])

        convertedPattern = {}

        for i = 1,#itemData do
            
            key = itemData[i][1]
            value = itemData[i][2]
            convertedPattern[value] = {}

            for slot = 1,9 do
                if string.sub(patternStr, slot, slot) == key then
                    table.insert(convertedPattern[value], slot)
                    print(textutils.serialize(convertedPattern))
                end
            end
        end

        recipeData["pattern"] = convertedPattern


    --else
        --make shapeless pattern
        --based on ingredient list
    end
    --Pattern end

    recipeData["product"] = fileData["result"]["id"]
    recipeData["count"] = fileData["result"]["count"]

    return recipeData

end


recipes = {
    patterns = patterns,
    nameFormatter = nameFormatter,
    defineRecipe = defineRecipe,
    recipeLookup = recipeLookup,
    convertSlot = convertSlot }

return recipes
--recipes.function()