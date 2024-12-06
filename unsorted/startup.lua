--Todo
--No idea what to do here, really.
--Should probably make this look nicer, and generally just... better code.

loop=0
name="Link"
print("Initilizing...")


require(".system/notes")
print("Directory at '"..notes.dir.."'")


package.preload ["peripherals"] = require(notes.dir.."peripherals")
print("Loaded peripherals")
--printVerbose("Peripherals found:)
--loop and print non nil peripherals.

package.preload ["logic"] = require(notes.dir.."logic")
print("Loaded logic lib")

package.preload ["wireless"] = require(notes.dir.."wireless")
print("Loaded wireless lib")



peripherals = require(notes.dir.."peripherals")
logic = require(notes.dir.."logic")
wireless = require(notes.dir.."wireless")

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
