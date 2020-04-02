
mon=peripheral.find("monitor")
perp=false --Immibis peripherals  (gets checked with server)
loop=0
name=="Link"


function Main()
    if fs.
    git("functions/help.lua","help")
    git("functions/mtext.lua","mtext")
    git("functions/maths.lua","calc")
    --backup, just incase. also for more complex code :/ oh well.
    pullBack = pullEvent
    osPullBack = os.pullEvent
    rawBack = os.pullEventRaw
    --disable events...
    local pullEvent = os.pullEvent
    os.pullEvent = os.pullEventRaw
    
    term.clear()
    term.setCursorPos(1,1)
        if mon~=nil then
            mwrite("Use the connected Monitor?\n Warning: This 'os*' is not very well built for a monitor\n (y/n)\n>")--it isnt. working on that now...
            if read()=="y" then -- using the word OS very streached here
                    monitors=true
                    mon.setTextScale(0.5)
                    mon.clear()
                    mon.setCursorPos(1,1)
                else
                    mwrite("\nImpromper input or input was no\n")
            end
        end

    local pass = {'not','getting','mypass'} --  :P
    if pocket then
        mprint("WARNING: NOT OPTIMIZED FOR POCKET COMPUTERS")
    end

    mwrite("Enter Password: ")
    local input=read("*")
    if input==pass[1] then
            mprint("WARNING: SIGNED IN AS GUEST. RESTRICTIONS ENABLED")
            user = 0 --note; user=0 is guest, user=1 is a friend, user=2 is main
            sleep(2)
        elseif input==pass[3] then
            mprint("NOTICE: SIGNED IN AS FRIEND. SOME RESTRICTIONS NOT REMOVED")
            user = 1
            sleep(2)
        elseif input==pass[2] then
            mprint("SIGNED IN AS "..name..". RESTRICTIONS REMOVED")
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

    servercheck(ipcheck())

    while exitvar do
		if user>=2 and seen==1 then
            mprint("Welcome back "..name.."!")
            seen=1
		end
        mwrite("What do you want to do? (help for list)\n>")
        local inputb=read()
			dolua(inputb)
    end
end
 
function permerr()
    mprint("WARNING: INSUFFICIENT PERMMISIONS\n YOUR LEVEL: "..user.."\n>")
end

function dofun()
    mwrite("\nType the EXACT name of the function\n>")
    local doing=load(read())
    doing()
end

function run()
    mprint("What do you wish to run?")
    mwrite("Note: type the whole command, like \n'>chat host Internet Link'\n>") --too lazy to check for args.
    shell.openTab(read())
end

function discord()
    mprint("Join the discord that i for some reason made for this repo!")
    mprint("https://discord.gg/MYyHVzB")
end

function timer(time)
    min=convertTime(time)
        while time>0 do
            term.setCursorPos(1,3)
            term.clear()
            mwrite("Seconds:"..time)
            term.setCursorPos(1,1)
            if min>1 then
                mwrite("Minutes:"..min)
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

function discogen()
    head = {}
    --what do my var names even mean? XD. im sure im avoiding duplicate names but...
    GenCos="https://discordapp.com/595567348916944915/595567348916944919"
    mprint("Paste link?")
    mwrite("y / n\n>")
        if read()=="y" then
                mwrite("Paste channel link\n>")
                discordlink=read()
                disco=http.get(discordlink,"")
            else
                mwrite("What channel?\n General-CC = CCG \n General-Cosmic = GC")
                input=read()
                if input==CCG then
                    discordlink=GenCos
                end
        end
    disco=http.get(discordlink)
    disco.readAll()

end

Main()