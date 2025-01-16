require("wireless")

local args = {...}

--wireless {wired modem} {wireless modem} [relay amount // true for infinite]

local wired = args[1]
local wireless = args[2]
local loops = args[3]

--does... does wireless side even matter to specify?
-- meh.

if peripheral.call(wired, "open", 1) ~= true then
    error("Wired modem (arg 1) not a modem")
elseif peripheral.call(wireless, "open", 1) == true then
    error("Wireless modem (arg 2) not a modem")
end

if loops == "true" or loops == "t" or loops == "y" or loops == "-1" then
    loops = true
elseif loops ~= nil then
    loops = tonumber(loops)
end

airTranscieveWire(wired, wireless, loops)