require("logic")

local ui = {}
--sigh. okay, lets go...

function ui.page(name,desc,buttons)
    --Makes a 'page' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
    term.setCursorPos()
    write(name)

end

function ui.button(name, luaChunk, location, key)

    local x,y = 0
    if location then
        x,y = location.x,location.y
    elseif not settings.get("sys.ui.buttonpos") then
        settings.set("sys.ui.buttonpos",{})
    end
end

return ui