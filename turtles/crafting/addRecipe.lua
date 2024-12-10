--Todo
--Not completed yet. So do that.
--Honestly i would like to have the recipes stored on git so i can
--just download the entire folder and define them all.
--Have a folder per mod. (Yes, link, 'minecraft' is a mod.)

args = {...}

require("recipeHandler")

--filename should include .extensions
--setup to define folders
if args[1] == "file" then

    for iter = 2, #args do
        fileName = args[iter]

        produceItem, extend = recipes.nameFormatter(fileName)

        if extend == ".json" then
            recipeData = jsonRecipeConvert(fileName)
            produceItem = recipeData["product"]
        else
            fromFile = fs.open(fileName, "r")
            recipeData = fromFile.readAll()
        end

        recipes.defineRecipe(produceItem, recipeData, nil, true, "i")

    end



elseif args[1] == "user" then

    recipeName = args[2]
    recipeData = {recipeName}
    itemName = args[3]
    --itemName = {}
    itemRecipe = {}

    for iter = 4, #args do

        if tonumber(args[iter]) == nil then
            tempRecipe = {[itemName] = itemRecipe}
            recipeData = table.insert(recipeData)
            itemName = args[iter]
        else
            args[iter] = tonumber(args[iter])
            recipeData = table.insert(itemRecipe, args[iter])
        end
    
    end
else
    print("Invalid input!")
    print("addRecipe file||user [recipe]")
    print("File adds a list of files,")
    print("User adds one based on next input")
end