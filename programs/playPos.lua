modem = peripheral.find("modem")
player = peripheral.find("playerDetector")

COL = false
term.setTextColor( colors.lightBlue )

while true do

local TAB = player.getOnlinePlayers()

--k=key, but the array is jut a numbered list
--starting at 1 normally. Can be used as iterator.
    playerMessage = {}
    
for k,playerName in pairs(TAB) do
    pos = player.getPlayerPos(playerName)
    term.setCursorPos(1,k)
    term.clearLine()
    
    if pos["x"] == nil then
        local tempMSG = playerName.." Is not in this dimension!"
        playerMessage[k] = tempMSG
        write(tempMSG)
    else
        
        local tempMSG = playerName..":  x="..pos["x"]..", y="..pos["y"]..", z="..pos["z"]
        playerMessage[k] = tempMSG
        write(tempMSG)
    end
end

--Alternate colours every 'tick'
if COL == false then
    term.setTextColor( colors.blue )
    COL = true
else
    term.setTextColor( colors.lightBlue )
    COL = false
end

sleep()
end --While true
