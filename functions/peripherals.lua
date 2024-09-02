--I'll fill this up as a learn of new peripherals.

return {
--CC:T
monitor = peripheral.find("monitor"),
commandBlock = peripheral.find("command"),
diskDrive = peripheral.find("drive"),
printer = peripheral.find("printer"),
speaker = peripheral.find("speaker"),

--modem. Can only handle ONE though.
modem = peripheral.find("modem"),

--Generic CC:T
energyStorage = peripheral.find("enery_storage"),
fluidStorage = peripheral.find("fluid_storage"),
inventory = peripheral.find("inventory"),

--Advanced Peripherals
--https://docs.advanced-peripherals.de/
chatBox = peripheral.find("chatBox"),
energyDetector = peripheral.find("energyDetector"),
environmentDetector = peripheral.find("environmentDetector"),
playerDetector = peripheral.find("playerDetector"),
inventoryManager = peripheral.find("inventoryManager"),
nbtStorage = peripheral.find("nbtStorage"),
blockReader = peripheral.find("blockReader"),
geoScanner = peripheral.find("geoScanner"),
redstoneIntegrator = peripheral.find("redstoneIntegrator"),
arController = peripheral.find("arController"),
--Mod compat
meBridge = peripheral.find("meBridge"), --AE2
rsBridge = peripheral.find("rsBridge"), --Refined Storage
colonyIntegrator = peripheral.find("colonyIntegrator") --MineColonies

--Extreme Reactors


}