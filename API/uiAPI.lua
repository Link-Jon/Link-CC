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
UIcurrPos = {1,1}
UIpageList = {}

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
settings.define("sys.ui.page", {
    description = "Current page/subpage"
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
    UIscrData[textID] = {id}


    if id.pos then

        --would like to define mutliple at once but...
        --that can happen when i stop redesigning the ui code.
        if UiposData[textID] then
            ui.write("Warning, redefining posID: "..textID)
            UIposData[textID] = id.pos
        else
            UIposData[textID] = id.pos
        end
        
        if not next then; next = id.pos[1]; end --Prep for next
    end

    if id.text then

        if UItextData[textID] then
            ui.write("Warning, redefining textID: "..textID)
        end

        UItextData[textID] = {text = id.text}
        if id.style then; UItextData[textID].style = id.style; end
    end

    if id.button then --if button

        if UIbuttonData[textID] then
            ui.write("Warning, redefining buttonID: "..textID)
        end

        if not id.style then; 
            UItextData[textID].style = "button"
            UIscrData[textID].style = "button"
        end --Set Style
        
        if type(id.button.action) == "function" then --Enforce id.button.action
            UIbuttonData[textID].action = id.button.action
        elseif id.button.action == nil then
            UIbuttonData[textID].action = function(); print("Button not setup"); sleep(1); end
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
        next = next+#id.text; 
    end
    return next
end


--------ui.draw--------
--id = text id
--location = {x,y} or location = "pos name"
function ui.draw(textID, posID, drawBool)

    if drawBool == false then
        return false
    end
    local id = {text = textData[textID], pos = posData[textID], button = buttonData[textID]}

    selected = settings.get("sys.ui.selected")

    local currStyle = "default"

    if selected.id == textID then
        currStyle = "blink"
    elseif selected.right == textID or selected.left == textID or selected.down == textID or selected.up == textID then
        currStyle = "highlight"
    elseif currStyle == "default" and id.text.style then
        currStyle = id.text.style
    end

    local pos = id.pos
    if posID ~= nil and posID ~= textID then
        --if pos name, fetch posData
        if type(posID) == "string" then; pos = posData[posID];
        --Else, raw posData
        elseif type(posID) == "table" then; pos = posID; end
    end

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

--if i ever actually need to do this
--i will probably do it myself.
function ui.center(middle, text, right)
    local median = table.length(text)

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

function ui.loadPage(pageID)


    if not pageID then
        pageID = settings.get("sys.ui.page")
    end

    if UIpageList[pageID] ~= nil then
        return UIpageList[pageID]

    elseif fs.isDir(pageID) then
        UIpageList["main"] = require(args[1].."/main")

    elseif fs.exists(pageID) then
        UIpageList[pageID] = require(pageID)

    elseif fs.exists(pageID..".lua") then
        UIpageList[pageID] = require(page)
        error("Cannot load "..pageID.." as it does not exist")
    end

    return UIpageList[pageID]
end
--[[
To be added...

function ui.createPage(name,desc,text,buttons)
    --Makes a 'page' using the name + description,
    --and letting the user select the buttons

    errcheck(name,"string",nil,true)
    if errcheck(desc,"string") then; desc = {desc}; end
    errcheck(desc,"table",nil,true)

    term.clear()
end

function ui.page(name, redraw)

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

    local page = ui.selectPage()
  
    if buttonID ~= nil and buttonID ~= "none" and buttonID ~= "wait" then
        settings.set("sys.ui.selected", buttonData[buttonID])
    else
        buttonID = settings.get("sys.ui.selected")
    end
    
    if buttonID == "wait" or buttonID == "none" then
        return false, "waiting"
    end

    if type(buttonID) == "table" then; buttonID = buttonID.id; end
    local currButton = buttonData[buttonID]
    local event, input, held = os.pullEvent("key")
    
    if input == keys.enter or input == keys.numPadEnter then
        settings.set("sys.ui.selected", "none")
        currButton.action()

    elseif (input == keys.w or input == keys.up) and currButton.up ~= nil then
        buttonID = currButton.up
        currButton = buttonData[buttonID]
        settings.set("sys.ui.selected", currButton)
        

    elseif (input == keys.s or input == keys.down) and currButton.down ~= nil then
        buttonID = currButton.down
        currButton = buttonData[buttonID]
        settings.set("sys.ui.selected", currButton)
        

    elseif (input == keys.a or input == keys.left) and currButton.left ~= nil then
        buttonID = currButton.left
        currButton = buttonData[buttonID]
        settings.set("sys.ui.selected", currButton)
        

    elseif (input == keys.d or input == keys.right) and currButton.right ~= nil then
        buttonID = currButton.right
        currButton = buttonData[buttonID]
        settings.set("sys.ui.selected", currButton)
        

    elseif input == keys.backspace then
        local pagePath = settings.get("sys.ui.pagePath")
        if #pagePath > 1 then
            pagePath = table.remove(pagePath)
        else
            return "exit"
        end
    end

    sleep(0.1)
end

