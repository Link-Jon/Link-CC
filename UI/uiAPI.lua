local logic = require("logic")
local inv = require("inventoryAPI")

--allow for key lookup via key number, later.
revKeys = {}
for key,value in pairs(keys) do
    revKeys[value] = key
end

local ui = {}
UIscrData = {}
UIposData = {}
UItextData = {}
UIbuttonData = {}
UImenuData = {}
UIcurrPos = {1,1}
UImenuList = {}

style ={
    default = {colours.white, colours.black},
    highlight = {colours.yellow, colours.black},
    blink = {colours.orange, colours.blue},
    button = {colours.brown, colours.black},
    seperator = {colours.lightGrey, colours.black},
    list = {colours.cyan, colours.black},
    curr = "default"
}

function ui.styleTest()
    term.clear()
    for i in style do 
        ui.style(i)
        print(i.."looks like this")
    end
    sleep(2)
    --io.read()
end


--Used incase of parallel, as i cant change globals through coroutines (luckily)
settings.define("sys.ui.selected", {
    description = "Currently highlighted button(s)",
    type = "table"
})
settings.define("sys.ui.menu", {
    description = "Current menu/submenu"
})

function ui.setStyle(styleset)
    term.setTextColour(styleset[1])
    term.setBackgroundColour(styleset[2])
end

--===================--
-----Text handlers-----
--===================--


-------ui.define-------
--[[
Very simplified from the old implimentation
id = {
    id = "stringID",

    pos = {x, y} or "pos name",
    
    text = "string",
    style = "style format",

    button = {
        id = "stringID",
        action = function(),
        up = nil, 
        down = nil, 
        left = nil, 
        right = nil},
    }
next = {x,y} or "pos name"
]]
function ui.define(id, next)
    local textID = id.id
    local menuID = settings.get("sys.ui.menu")

    if id.keyaction then; for k,v in pairs(id.keyaction) do

        UImenuData[menuID][k] = v

    end;end
    

    if id.pos then

        --would like to define mutliple at once but...
        --that can happen when i stop redesigning the ui code.
        if UIposData[textID] then
            ui.write("Warning, redefining posID: "..textID)
            UIposData[textID] = id.pos
        else
            UIposData[textID] = id.pos
        end

        if id.replaceable then; UIposData[textID].replaceable = true; end
        if not next then; next = id.pos[1]; end --Prep for next
    end

    if id.text or id.replaceable then

        if UItextData[textID] then
            ui.write("Warning, redefining textID: "..textID)
        end

        UItextData[textID] = {text = id.text}
        if id.style then; UItextData[textID].style = id.style; end
        if id.replaceable then; UItextData[textID].replaceable = true; end
    end

    if id.near or id.action then --if button

        if UIbuttonData[textID] then
            ui.write("Warning, redefining buttonID: "..textID)
        else
            UIbuttonData[textID] = {}
        end

        if not id.style and id.text then; 
            UItextData[textID].style = "button"
        end --Set Style
        
        if not id.near then --Enforce id.near
            UIbuttonData[textID].near = {id = textID} 
            vprint(textID.." has no id.near!")
        else
            UIbuttonData[textID].near = id.near
        end

        if type(id.action) == "function" then --Enforce id.button.action
            UIbuttonData[textID].action = id.action
        elseif id.action == nil then
            UIbuttonData[textID].action = function(); ui.write("Button not setup"); end
        else
            error(textID.." button's action is not a function, but also not nil")
        end

    end

    --[[
    hm. id.scroll and id.scrollID?
    id.scroll = number, location in list
    id.scrollID = string, all data with this ID scrolls together
    ]]
    --give end location
    if id.text and next then; 
        if type(id.text) == "string" then; id.text = #id.text; end
        next = next+id.text; 
    end
    return next
end


--------ui.draw--------
--id = text id
--location = {x,y} or location = "pos name"
function ui.draw(textID, extra, drawBool)

    if extra and extra.pos then extra.p = extra.pos; end;
    if extra and extra.text then extra.t = extra.text; end;
    
    if drawBool == false then; return false; end;

    local id = {text = UItextData[textID], pos = UIposData[textID]}
    local selected = settings.get("sys.ui.selected")
    local currStyle = "default"

    if selected.id == textID then; currStyle = "blink"
    elseif selected.right == textID or selected.left == textID or selected.down == textID or selected.up == textID then
        currStyle = "highlight"
    elseif id.text.style then
        currStyle = id.text.style
    end

    local pos = id.pos
    if extra and extra.p ~= nil and extra ~= textID then
        --if pos name, fetch posData
        if type(extra) == "string" then; pos = UIposData[extra];
        --Else, raw posData
        elseif type(extra) == "table" then; pos = extra; end
    end

    if extra and extra.p and (not id.text.text or id.text.replaceable) then; id.text.text = extra;
    elseif id.text.text == nil then; id.text.text = "!undefined text!"; end

    ui.setStyle(style[currStyle])
    term.setCursorPos(pos[1], pos[2])
    term.write(id.text.text)
    ui.setStyle(style.default)
    local next = pos[1] + #id.text.text
    return next
end

function ui.write(string)
    local x,y = term.getCursorPos()
    term.setCursorPos(1,13)
    term.write(string)
    term.setCursorPos(x,y)
end

function ui.clear(pos1,pos2,color)

    if UItextData[pos1] and UIposData[pos1] then
    --if we recieved an ID
        term.setCursorPos(UIposData[pos1][1],UIposData[pos1][2])
        for i = 1,#UItextData[pos1] do
            write(" ")
        end

    elseif type(x1) == "array" and type(y1) == "array" then
    --if we got specific pos data
        
    end

    return true

end

--if i ever actually need to do this
--i will probably do it myself.
function ui.center(middle, text, right)
    local median = #text

    if type(middle) == table then
        middle = middle[1]
    end
    --to find the start location...
    --i need to go half text to the left of the midpoint
        middle = middle - median/2

    if middle < 1 then 
        return false, "text too big"
    else
        return middle
    end
end

function ui.loadMenu(menuID)

    local path = settings.get("sys.ui.menuPath")

    if path == {} and menuID == nil or menuID == "quit" then
        return "quit"
    elseif menuID == nil then
        menuID = settings.get("sys.ui.menu")
    end

    if path == nil or path == "false" or path == false then
        settings.set("sys.ui.menuPath", {})
        path = {}
    end

    if UImenuList[menuID] ~= nil then
        ui.nextMenu(menuID)
        return UImenuList[menuID]

    elseif fs.isDir(menuID) then
        local unloadedMenus = fs.list(menuID)
        local findStart = false
        for i = 1, #unloadedMenus do
            unloadedMenus[i] = string.gsub(unloadedMenus[i],".lua","")
            UImenuList[unloadedMenus[i]] = require(menuID.."."..unloadedMenus[i])
            if unloadedMenus[i] == "main" or unloadedMenus[i] == "init" then
                findStart = unloadedMenus[i]
            end
        end

        if not findStart then
            findStart = unloadedMenus[1]
            print("Warning. Did not find specific 'main' or 'init'")
            print("Using first loaded...")
            sleep(1)
        end

        ui.nextMenu(menuID)
        return UImenuList[findStart]

    elseif fs.exists(menuID) or fs.exists(menuID..".lua") then
        
        UImenuList[menuID] = require(menuID)
        UImenuData[menuID] = {}
        
        ui.nextMenu(menuID)
        return UImenuList[menuID]
    else
        error("Cannot load "..menuID.." as it does not exist")
    end
end

function ui.nextMenu(menuID)
    local oldMenu = settings.get("sys.ui.menu")

    if oldMenu == menuID then
        return false; end

    local path = settings.get("sys.ui.menuPath")
    if path == nil or path == "false" or path == false then
        path = {menuID}; end

    table.insert(path,menuID)
    settings.set("sys.ui.menuPath", path)
    settings.set("sys.ui.menu", menuID)

end

function ui.prevMenu()

    local path = settings.get("sys.ui.menuPath")
    table.remove(path)
    settings.set("sys.ui.menuPath", path)
    settings.set("sys.ui.menu", path[#path])

end

--[[
To be added...

function ui.createmenu(name,desc,text,buttons)
    --Makes a 'menu' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
end

function ui.menu(name, redraw)

    require("name")
    something.. something

end]]

--===================--
---End text handlers---
--===================--



--startpos = {x,y}
--id = "{"id","text"} --text = "string"
--near = {left = button, right = button ...}
--action = function()
--key = "string" for keys[string] or keys.abc


function ui.selector(buttonID)

    local menu = ui.loadMenu()
    local path = settings.get("sys.ui.menuPath")
    
    if buttonID ~= nil and buttonID ~= "none" and buttonID ~= "wait" then
        settings.set("sys.ui.selected", UIbuttonData[buttonID].near)
    else
        buttonID = settings.get("sys.ui.selected")
    end
    
    if buttonID == "wait" or buttonID == "none" then
        return "waiting"
    end

    if type(buttonID) == "table" then; buttonID = buttonID.id; end
    local currButton = UIbuttonData[buttonID]
    local near = currButton.near
    ui.write(textutils.serialise(path))
    local event, input, held = os.pullEvent("key")
    
    if input == keys.enter or input == keys.numPadEnter then
        --settings.set("sys.ui.selected", "none")
        local succ, why = pcall(currButton.action)
        --ui.write(tostring(succ))
        if not succ then; ui.write(why); end

    elseif (input == keys.w or input == keys.up) and near.up ~= nil then
        buttonID = near.up
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        menu.draw("button")


    elseif (input == keys.s or input == keys.down) and near.down ~= nil then
        buttonID = near.down
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        menu.draw("button")


    elseif (input == keys.a or input == keys.left) and near.left ~= nil then
        buttonID = near.left
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        menu.draw("button")


    elseif (input == keys.d or input == keys.right) and near.right ~= nil then
        buttonID = near.right
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        menu.draw("button")
        
    elseif input == keys.backspace then

        ui.prevMenu()

        --keyactions!
    elseif UImenuData[menu.name] then 
        for k,v in pairs(UImenuData[menu.name]) do
        if k == input then
            v()
        end;end
    end 

    sleep(0.1)
end

return ui
