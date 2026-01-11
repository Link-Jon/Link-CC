--Requires Advanced Peripherals
--(Needs a chat box)

--Link~

--Do not make a new file if the previous file
--has less than this many lines written:
local softLineLimit = 500

local chatV1 = peripheral.find("chatBox")
local chatV2 = peripheral.find("chat_box")


if chatV1 then
    chat = chatV1
elseif chatV2 then
    chat = chatV2
else
    error("No chat box found. Check if peripheral attatched; or if peripheral name 'changed'.")
end


print("Preping file")
logNum = 1
print(fs.exists("log/log1"))
while fs.exists("log/log"..logNum) == true do
    logNum = logNum + 1
    print(logNum)
    if logNum >= 100 then
        sleep() -- this loop could likely get long enough to reach 'to long without yeilding'
    end
end

print("Found at log"..logNum)

--[[Todo:
Check if a log file has gone past X (configurable) number of lines.
Default to 500
If so, make a new file.
If not, append onto the previous file.

Will not prevent a log going beyond 500 lines, 
just prevent making a new one after this point
]]--
LF = fs.open("log/log"..logNum, 'w')
--LF; Logfile

LF.write("Start of Record.\n")
print("Start of Record")
LF.write(os.date())
print(os.date())
while true do
    local event, username, msg, uuid, isHidden = os.pullEvent("chat")
    --get data from chat (Chat Box)
    
    if isHidden then 
        --Moved chatting function to chatter.lua
        
        isHidden = 1 --cannot concat a bool
    else isHidden = 0 end --so we make it a number
    
    LF.write("["..isHidden.."] "..username..": "..msg.."\n")
    write("["..isHidden.."] "..username..": "..msg.."\n")
    --write() not print() to make fs.write()
    --function in the same way, no extra formatting
    
    LF.flush() --save file
end   


