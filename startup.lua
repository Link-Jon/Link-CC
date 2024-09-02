mon=peripheral.find("monitor")
loop=0
name="Link"
print("Initilizing...")
--[[ if os.loadAPI then
        require = os.loadAPI
     end --Think it might be simpler to have the table.function set to require if it exists.

90% sure this is attempted compatiblity between CC and CC:T
Abandoned.
--]]

require(".system/notes")

 = require(notes.dir.."mtext")


-- I think i need to start from scratch, honestly.
--Alright. Mtext is probably the best API here, so lets work on that next.

--Moving all the... login... stuff. to a functions/cui file

https.servercheck(https.ipcheck())

while true do
if user>=2 and seen==1 then
    mprint("Welcome back "..name.."!")
end

mwrite("What do you want to do? ('help' for a list)\n>")
local inputb=read()
dolua(inputb)
end
