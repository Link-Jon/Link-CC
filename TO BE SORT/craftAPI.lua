--[[
GOAL. so. ugh.
...AUGUGHGHGUAHGHU i dont want to do this
but i really, REALLY need to
This should be capable of crafting any registered recipe
It will call another script to register new recipes if needed.

It should be a callable function AND usable as a program.
... Unfortunately i have to do this later though.
its 2pm right now and i have work to do.
--]]

require("recipeHandler")

--require(invhandler?)
function craft(product, toMake, recipeNum)

    if not turtle or not turtle.craft then
        error("Crafty turtle required to run")
    end

    recipe = recipeLookup(product, recipeNum)

    recipe =

end

return {craftAPI = {
    craft = craft
}}

--]]