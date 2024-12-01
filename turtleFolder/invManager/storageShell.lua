local args = {...}
modem = peripheral.wrap("modem")
if modem then modem.open(220) end

require("storageHall")

if args[1] == "scan" then
    inspectStorage()
end

while true do

    term.set()
    term.write()s
    print("Welcome! What would you like to do?")
    print("request items; scan inventory; re-init; help")
    print("request | scan | init | help")

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
    
    --string.gsub(input, " ", "")
    while input do --??
    
    input, replacements = string.gsub(input,"request ","",1)
    print(replacements)
    if replacements == 1 then
        --Handle a request
    end


    end
    ]]
end