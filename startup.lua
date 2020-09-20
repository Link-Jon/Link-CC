mon=peripheral.find("monitor")
print("monitor checked")
perp=false --Immibis peripherals (gets checked with server)
loop=0
name="Link"
print("Initilizing...")
os.loadAPI(".system/notes")
print("loaded notes")
    --note work
    local str=string.sub(notes.dir,-2,-1)
    if str ~= '/' or str ~='\\' then
        notes.dir=notes.dir.."/"
    elseif str == '\\' then
        notes.dir=string.sub(notes.dir,1,-2).."/"
    end
os.loadAPI(notes.dir.."mtext")
print("loaded mtext")
os.loadAPI(notes.dir.."https")
print("loaded https")
os.loadAPI("dofun")
print("loaded dolua")

function Main()
    --backup, just incase. also for more complex code :/ oh well.
    pullBack = pullEvent
    osPullBack = os.pullEvent
    rawBack = os.pullEventRaw
    --disable events...
    local pullEvent = nil
    os.pullEvent = nil
    os.pullEventRaw = nil
    
    term.clear()
    term.setCursorPos(1,1)
    mtext.montest()
    print("events off")

    local pass = {'not','getting','mypass'} --  :P

    if pocket then-- because its not \/
        mtext.mprint("WARNING: NOT OPTIMIZED FOR POCKET COMPUTERS")
    end
    print("pocket warn")
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

    while exitvar do
		if user>=2 and seen==1 then
            mtext.mprint("Welcome back "..name.."!")
            seen=1-- get from a file?
		end
        mtext.mwrite("What do you want to do? (help for list)\n>")
        local inputb=read()
			dofun.dolua(inputb)
    end
end


function discord()
    mtext.mprint("Join the discord that i for some reason made for this repo!")
    mtext.mprint("https://discord.gg/MYyHVzB")
end

function timer(time)
    min=convertTime(time)
        while time>0 do
            term.setCursorPos(1,3)
            term.clear()
            mtext.mwrite("Seconds:"..time)
            term.setCursorPos(1,1)
            if min>1 then
                mtext.mwrite("Minutes:"..min)
            end
            time=time-0.1
            min=min-0.1/60
            sleep(0.1)
        end--WARNING: minutes are not accurate...enough for me anyway
end

function convertTime(time)
    time=time/60
    return(time)
end

Main()