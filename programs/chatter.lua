--Todo
--see chatLogger.lua

--Stylized for "play.dw20.ca"
--Requires Advanced Peripherals
--(Needs a chat box)

--Link~

args = {...}
if type(args[1]) ~= "string" or type(args[2]) ~= "string" and args[2] ~= nil then
   
   print("Incorrect usage;")
   print("chatter {username} [prefix]")
   
   error("No username or args are not strings?") 
end
local username = args[1]
local prefix = args[2]
local chat = peripheral.find("chatBox")

while true do
        
    write("> ")
    msg = io.read()        
    --This should be easier to read.
    if msg == "exit" then
        break
    elseif msg == "edit" then
        shell.openTab("edit chatter.lua")
        break
    end
    
    msg = string.gsub(msg,"%&","§")
    msg = string.gsub(msg,"%$","§")
    print(msg)
    
    premsg = "§7- "..username.."§f: "
    if prefix == nil then
        prefix = "§6CraftOS§r"
    end
    brackets = "[]" --brackets
    bracketColor = "&8" --'bracketcolor', same as normal color codes, but with &
        
    chat.sendMessage(premsg..msg, prefix, brackets, bracketColor)
end
