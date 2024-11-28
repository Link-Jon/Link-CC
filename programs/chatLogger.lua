--Stylized for "play.dw20.ca"
--Requires Advanced Peripherals
--(Needs a chat box)

--Link~

local chat = peripheral.find("chatBox")

print("Preping file")
logNum = 1
print(fs.exists("log/log1"))
while fs.exists("log/log"..logNum) == true do
    logNum = logNum + 1
    print(logNum)
end
print("Found at log"..logNum)
--if it exists, use 'append'. else 'write' a new file
LF = fs.open("log/log"..logNum, 'w')
--LF; Logfile

LF.write("Start of Record.\n\n")-- Hopefully
while true do
    local event, username, msg, uuid, isHidden = os.pullEvent("chat")
    --get data from chat (Chat Box)
    
    if isHidden then 
       
        --[[
        msg = "§"..msg
        unsure if this is better, or if
        doing it in the giant chain is better..
        
        either way, append [ALT+21] to the start 
        of the message, changing its colour
        --]]
        
        
        --Harder to read, i guess...
        premsg = "§7- "..username.."§f: §"
        msg = msg
        prefix = "§6CraftOS§r"
        brackets  = "[]"
        bracketColor = "&8" --same as normal color codes, but with &
        
        All together:
        chat.sendMessage(premsg..msg, prefix, brackets, bracketColor)
        --[[
        i dont use 'distance' but its just how close do
        players need to be to recieve the messag, in blocks.
        Distance would be a number, after bracketcolour
        
        --]]
        
        isHidden = 1 --cannot concat a bool
    else isHidden = 0 end --so we make it a number
    
    LF.write("["..isHidden.."] "..username..": "..msg.."\n")
    
    write("["..isHidden.."] "..username..": "..msg.."\n")
    --write() not print() to make fs.write()
    --function in the same way, no extra formatting
    
    LF.flush() --save file
    --could make a cache collecting uuid with usernames but 
    --i dont feel like it right now
end   

