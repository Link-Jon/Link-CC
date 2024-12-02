local args = {...}
local modem = peripheral.wrap("modem")
if modem then modem.open(220) end

require("storageHall")
require("logic")
require("uiAPI")

local function vprint() end -- so vprint is a REAL function, even when not verbose.

if args[1] == "scan" then
    inspectStorage()
elseif args[1] == "verbose" then
    function vprint(text)
        term.setTextColor(2^6)
        print(text)
        term.setTextColor(2^0)
        io.read()
        sleep(0.25)
    end
end


while true do

   

    --HOW DO I WANT TO DO THIS AHGHGASGHADGAWE
    --i am SO annoying why am i writing this an not just MAKING up my MIND UGH

    --sigh.
    --this will probably stay on pause for a very, long time.
    --Mostly because im not sure what i want to do, and im not sure
    --how to do most of my ideas, and some of em i just dont want to
    --use other's library code, for ... some reason.
--[[
    while true do
    event, side, channel, rplyChannel, input, distance = os.pullEvent()
     
        if event == "modem_message" and rplyChannel == 221 then
            --Stuff from wireless to do

        elseif event == "key" then
            --
            if keys.r then

            end
        end
    end

   ]]

    --SCREW IT
    term.clear()
    term.setCursorPos(1,1)

    write("Welcome! What would you like to do?\n")
    --write("request items; scan inventory; re-init; help\n")

    local next = ui.button({5,5},{"request","request"}, {right = "scan"}, itemMenu)
    term.write(" | ")
    next = next + 3
 
    next = ui.button({next, 5},{"scan","scan"}, {left = "request", right = "init"}, scan)
    term.write(" | ")
    next = next + 3
    
    next = ui.button({next, 5},{"init","init"}, {left = "scan", right = "help"}, initPrep)
    term.write(" | ")
    next = next + 3
    
    next = ui.button({next, 5},{"help","help"}, {left = "init"}, helpShell)

    ui.selector("request")
end



--[[


function ui.split(startPos, name, data, action)
    
end]]