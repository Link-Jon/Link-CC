--modem = peripheral.find("modem")
player = peripheral.find("playerDetector")

COL = false
term.setTextColor( colors.lightBlue )

while true do

local TAB = player.getOnlinePlayers()

--k=key, but the array is jut a numbered list
--starting at 1 normally. Can be used as iterator
--playerMessage = {}
    i = 0
    
for k,playerName in pairs(TAB) do

    i=i+1
    pos = player.getPlayerPos(playerName)
    term.setCursorPos(1,i)
    term.clearLine()
    
    if pos["x"] == nil then
        local tempMSG = playerName.." Is not in this dimension!"
        --playerMessage[k] = tempMSG
        write(tempMSG)
    else
        
        i=i+1
        write(playerName..": ")
        term.setCursorPos(1,i)
        term.clearLine()
        write("x="..pos["x"]..", y="..pos["y"]..", z="..pos["z"])
        
        --playerMessage[k] = tempMSG
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
