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


function sectionSignHandling(msg)
   --First: prevent 'escaped' characters from being changed
   msg = string.gsub(msg, "%\%$", "__DOLLARSIGN__")
   msg = string.gsub(msg, "%\%&", "__AMPERSAND__")

   --Second: Replace non 'escaped' characters with the section sign (§)
   msg = string.gsub(msg, "%$", "§")
   msg = string.gsub(msg, "%&", "§")

   --Third: Return 'escaped' characters to normal
   msg = string.gsub(msg, "__DOLLARSIGN__", "$")
   msg = string.gsub(msg, "__AMPERSAND__", "&")

   return msg
end

--Chat functionality from inside the computer
--probably a pocket computer.
function computerChatter()        
    write("> ")
    msg = io.read()        
    --This should be easier to read.
   if msg == "exit" then
      break
   elseif msg == "edit" then
      shell.openTab("edit chatter.lua")
      break
   end
   
   msg = sectionSignHandler(msg)
    
   premsg = "§7- "..username.."§f: "
   if prefix == nil then
      prefix = "§6CraftOS§r"
   end
   brackets = "[]" --brackets
   bracketColor = "&8" --'bracketcolor', same as normal color codes, but with &
        
   chat.sendMessage(premsg..msg, prefix, brackets, bracketColor)
end

--chat functionality from within chat;
--via '$' hidden messages
function hiddenChatter()

   --todo: Unify the 'preset' between the two.
   premsg = "§7- "..username.."§f: "
   msg = msg
   prefix = "§6CraftOS§r"
   brackets  = "[]"
   bracketColor = "§8"

   msg = sectionSignHandler(msg)
   
   --All together:
   chat.sendMessage(premsg..msg, prefix, brackets, bracketColor)
end

function standardChat()
   --Show chat in terminal.
   while true do
      sleep(0)
   end
end

--------

while true do
   parallel.waitForAny(
      computerChatter,
      hiddenChatter,
      standardChat
   )
   
   sleep()
end
