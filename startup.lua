mon=peripheral.find("monitor")
print("monitor checked")
perp=false --Immibis peripherals (gets checked with server)
loop=0
name="Link"
print("Initilizing...")
os.loadAPI(".system/notes")

os.loadAPI(notes.dir.."dofun")
os.loadAPI(notes.dir.."mtext")
os.loadAPI(notes.dir.."help")

function Main()
    --backup, just incase. also for more complex code :/ oh well.
    pullBack = pullEvent
    osPullBack = os.pullEvent
    rawBack = os.pullEventRaw
    --disable events...

    os.pullEvent = os.pullEventRaw

    term.clear()
    term.setCursorPos(1,1)
    mtext.montest()

    local pass = {'not','getting','mypass'} --  :P

    if pocket then-- because its not \/
        mtext.mprint("WARNING: NOT OPTIMIZED FOR POCKET COMPUTERS")
    end

    mtext.mwrite("Enter Password: ")
    local input=read("*")
    if input==pass[1] then
            mtext.mprint("WARNING: SIGNED IN AS GUEST. RESTRICTIONS ENABLED")
            user = 0 --note; user=0 is guest, user=1 is a friend, user=2 is main
            sleep(2)
        elseif input==pass[3] then
            mtext.mprint("NOTICE: SIGNED IN AS FRIEND. PARTIAL RESTRICTION ENABLED")
            user = 1
            sleep(2)
        elseif input==pass[2] then
            mtext.mprint("SIGNED IN AS "..name..". RESTRICTIONS REMOVED")
            --enable events.
            pullEvent = pullBack
            os.pullEvent = osPullBack
            os.pullEventRaw = rawBack
            --complex stuffs. first ask generic what do you want with a 'help'
            user = 2
            sleep(2)
        else
            os.reboot()
    end

    https.servercheck(https.ipcheck())
        seen=nil

        while true do
		if user>=2 and seen==1 then
            mtext.mprint("Welcome back "..name.."!")
        end

        mtext.mwrite("What do you want to do? ('help' for a list)\n>")
        local inputb=read()
		dofun.dolua(inputb)
        end
end


function discord()
    mtext.mprint("Join the discord that i for some reason made for this repo!")
    mtext.mprint("https://discord.gg/MYyHVzB")
end

Main()