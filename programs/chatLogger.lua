--Todo
--Allow for the 'style' to be changed easier than editting this file
--Make a set of defaults for the servers i visit...
    --yes this is 100% just to convience myself lol.

--oh hey thats a way to use the ip checker!

--Firstly, if args[1] is true, then overwrite/set the ip in settings.api

--if not, check if an ip has been set in settings.api
    --if ip in settings, check if it is the same ip adress that ipcheck returns
        --if this is true, we know the ip has not changed since last run and
        --use the current settings for server style
        
    --if ip and settings.api ip are different or if no settings.api ip
    --prompt user for server style
    --and set settings.api to the new ip


--Also. This chatlog will mean literally making the server
--hold onto one chat only log, and a full console log.
--That is extremely space ineffecient, this log should be stored somewhere else.
--However, as i dont think its a good idea for this log to go to pastebin or github, or anywhere public
--its best to send it directly to a recieving computer/server
--which... sounds like a bit of a pain to set up.
--shall have to investigate, and this will also end up being not usable for others
--as it will be my pc doing it. *sigh*



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

