require("wireless")

local args = {...}

--wireless {wired modem} {wireless modem} [relay amount // true for infinite]

local wired = args[1]
local wireless = args[2]
local loops = args[3]

--does... does wireless side even matter to specify?
-- meh.

if peripheral.getType(wired) ~= "modem" then
    error("Wired modem (arg 1) not a modem")
elseif peripheral.getType(wireless) ~= "modem" then
    error("Wireless modem (arg 2) not a modem")
end

if loops == "false" or loops == "f" or loops == "n" then
    loops = false
elseif loops ~= nil then
    loops = tonumber(loops)
else loops = true end

airTranscieveWire(wired, wireless, loops)

print("Program stopped? Press enter to continue")
io.read("")