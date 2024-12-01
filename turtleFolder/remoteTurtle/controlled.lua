--Todo
--This is 31 lines of code as of writing this.
--So, that is the goal. Finish

--To current me, the functionality is self explainitory.
--Maybe lessso for future me or others, so:

--Working with remote.lua, accept functions from the remote
--and execute them. Ment for remote controlled turtles,
--but im sure theres more that can be done here

--What is extra that really should be done,
--is having two control modes:
--The first is default, where the remote sends
--the functions to be executed as a string
--for us to load()
--The second, is sending the names of functions, and their arguments.
--Probably as a table now that we can.
--with the function name, run _G[funcName]
--Which in theory should run the function as expected.

--there may be a better way to do that, thats the first way i can think of
--to run "turtle.forward()" as a function.
    --oh right. need to tell the remote to
    --not have '()' in this mode.


local modem = peripheral.find("modem")
local APIList = {"logic","dwarfAPI"}

if not modem then
    modem = peripheral.find("wireless_modem") --these names may or may not work

    if not modem then
        error("No wireless modem detected.")
    end
end

modem.open(55)

while reply ~= 54 do
    event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
    if msg ~= "turtleping binary" and msg ~= "turtleping table" then
        reply = 0
    end
end

local lastConifg = settings.get("sys.remote.function")
local configBin = string.find(msg, "binary")
local configStr = string.find(msg, "table") 

if configBin or lastConfig == "binary" then
    --load binary strings...
    luaMagic = loadstring
    settings.set("sys.remote.function", "binary")
elseif configStr or lastConfig == "table" then
    luaMagic = function(input)
        return _G[input]
    end
    settings.set("sys.remote.function", "table")
end

modem.transmit(54, 55, "turtlepong")
_remoteActive_ = true
print("Controlled!")

while _remoteActive_ do
    -- temp ending, remove when making real function
    --recieve the code, ping that it was recieved,
    --do the code, and every 30 ish seconds send an update to the
    --remote. if we cannot, tell the remote we will ping when done
    --or SOS
    
    local event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
    if reply == 54 then
        modem.transmit(54,55, msg)
        local temp = luaMagic(msg)
        var1, var2, var3, var4, var5 = temp()
        modem.transmit(54,55, {var1, var2, var3, var4, var5})
    end
    --waiting...

end