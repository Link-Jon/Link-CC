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
    local pageID = settings.get("sys.ui.page")
    
    for k,v in pairs(currButton.keyaction) do

        UIpageData[pageID][k] = v

    end 
    

    if id.pos then

        --would like to define mutliple at once but...
        --that can happen when i stop redesigning the ui code.
        if UIposData[textID] then
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

    if id.near or id.action then --if button

        if UIbuttonData[textID] then
            ui.write("Warning, redefining buttonID: "..textID)
        else
            UIbuttonData[textID] = {}
        end

        if not id.style then; 
            UItextData[textID].style = "button"
            UIscrData[textID].style = "button"
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
            UIbuttonData[textID].action = function(); print("Button not setup"); sleep(1); end
        else
            error(textID.." button's action is not a function, but also not nil")
        end

        --add // allow for keyaction
        --keyaction = {keys.x = function(), keys.y = function(), ect.}

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
function ui.draw(textID, posID, textReplace, drawBool)

    --if disabled, dont draw.
    if drawBool == false then; return false;end

    local id = {text = UItextData[textID], pos = UIposData[textID]}
    local selected = settings.get("sys.ui.selected")
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
        if type(posID) == "string" then; pos = UIposData[posID];
        --Else, raw posData
        elseif type(posID) == "table" then; pos = posID; end
    end

    if textReplace then; id.text.text = textReplace;
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

function ui.loadPage(pageID)

    local path = settings.get("sys.ui.pagePath")

    if path == {} and pageID == nil or pageID == "quit" then
        return "quit"
    elseif pageID == nil then
        pageID = settings.get("sys.ui.page")
    end

    if path == nil then
        path = {}
    end

    if UIpageList[pageID] ~= nil then
        table.insert(path,pageID)
        settings.set("sys.ui.pagePath", path)
        settings.set("sys.ui.page", pageID)
        return UIpageList[pageID]

    elseif fs.isDir(pageID) then
        local unloadedPages = fs.list(pageID)
        local findStart = false
        for i = 1, #unloadedPages do
            unloadedPages[i] = string.gsub(unloadedPages[i],".lua","")
            UIpageList[unloadedPages[i]] = require(pageID.."."..unloadedPages[i])
            if unloadedPages[i] == "main" or unloadedPages[i] == "init" then
                findStart = unloadedPages[i]
            end
        end

        if not findStart then
            findStart = unloadedPages[1]
            print("Warning. Did not find specific 'main' or 'init'")
            print("Using first loaded...")
            sleep(1)
        end

        UIpageData[pageID] = {}
        settings.set("sys.ui.page", findStart)
        table.insert(path,findStart)
        settings.set("sys.ui.pagePath", path)
        return UIpageList[findStart]

    elseif fs.exists(pageID) or fs.exists(pageID..".lua") then
        
        UIpageList[pageID] = require(pageID)
        UIpageData[pageID] = {}
        
        settings.set("sys.ui.page", pageID)
        table.insert(path,pageID)
        settings.set("sys.ui.pagePath", path)
        return UIpageList[pageID]
    else
        error("Cannot load "..pageID.." as it does not exist")
    end
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

    local page = ui.loadPage()
    
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
    ui.write(page.name)
    local event, input, held = os.pullEvent("key")
    
    if input == keys.enter or input == keys.numPadEnter then
        --settings.set("sys.ui.selected", "none")
        local succ, why = pcall(currButton.action)
        if not succ then; ui.write(why); end

    elseif (input == keys.w or input == keys.up) and near.up ~= nil then
        buttonID = near.up
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        page.draw("button")


    elseif (input == keys.s or input == keys.down) and near.down ~= nil then
        buttonID = near.down
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        page.draw("button")


    elseif (input == keys.a or input == keys.left) and near.left ~= nil then
        buttonID = near.left
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        page.draw("button")


    elseif (input == keys.d or input == keys.right) and near.right ~= nil then
        buttonID = near.right
        currButton = UIbuttonData[buttonID]
        near = UIbuttonData[buttonID].near
        settings.set("sys.ui.selected", near)
        page.draw("button")
        
    elseif input == keys.backspace then
        --[[local pagePath = settings.get("sys.ui.pagePath")
        if #pagePath > 1 then
            pagePath = table.remove(pagePath)
        else]]
        return "exit"
        --end

        --keyactions!
    else; for k,v in pairs(UIpageData[page.name]) do
        if k == revKeys[input] then
            v()
        end;end
    end 

    sleep(0.1)
end

return ui
