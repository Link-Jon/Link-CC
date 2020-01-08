
mon=peripheral.find("monitor")
perp=false --Immibis peripherals  (gets checked with server)
loop=0
name=="Link"
exitvar=true --just incase i may ever use it...


function Main()
	  --git("functions/help.lua","help")
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
            if read()=="y" then -- using the word OS very streacged here
                    monitors=true
                    mon.setTextScale(0.5)
                    mon.clear()
                    mon.setCursorPos(1,1)
					git("functions/mtext.lua","mtext")
                else
                    mwrite("\nImpromper input or input was no\n")
            end
        end
    local pass = {'not','getting','mypass'} --  :P
    if pocket then
        mprint("WARNING: NOT OPTIMIZED FOR POCKET COMPUTERS")
    end

    mwrite("Enter Password: ")
	mprint("OH! how nice. this version gave you the password... but theres so much less stuff... here... in the first place.")
    local input='getting'--read("*")
    if input==pass[1] then
            mprint("WARNING: SIGNED IN AS GUEST. RESTRICTIONS ENABLED")
            user = 0 --note; user=0 is guest, user=1 is a friend, user=2 is me
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

    --servercheck(ipcheck())

    while exitvar do
		if user>=2 then
			mprint("Welcome back "..name.."!")
		end
        mwrite("What do you want to do? (help for list)\n>")
        local inputb=read()
		dolua(inputb)
   
    
function permerr()
    mprint("WARNING: INSUFFICIENT PERMMISIONS\n YOUR LEVEL:"..user.."\n>")
end
 
function calc()
    mwrite("First number:")
    numa=read()
    mprint("What type of calculation")
    mwrite("M / D / A / S\n>")
    fun=read()
    mwrite("Second number:\n>")
    numb=read()
    if fun=="M" or fun=="m" then
            numc=numa*numb
        elseif fun=="D" or fun=="d" then
            numc=numa/numb
        elseif fun=="A" or fun=="a" then
            numc=numa+numb
        elseif fun=="S" or fun=="s" then
            numc=numa-numb
    end


end
    


function Internet()
    local CN="string"
    local name="string"
    local style="string"
 
    term.clear()
    term.setCursorPos(1,1)
    term.mwrite("\nWhat kind of internet do you want (host/client)\n>")
    term.setCursorPos(1,2)
    style=io.read()
    if style=="join" then
            term.mwrite("What is the name of the chat? \n>")
            term.setCursorPos(1,4)
            CN=io.read()  
   
            term.mwrite("What shall you be called? \n>")
            term.setCursorPos(1,6)
            inname=io.read()
            shell.openTab("chat join "..CN.." "..inname)
        elseif style=="host" then
            term.mwrite("What will be the name of the chat?\n>")
            term.setCursorPos(1,4)
            CN=io.read()
            shell.openTab("chat host "..CN)
    end
end

function dofun()
    mwrite("\nType the EXACT name of the function\n>")
    doing=read()--warning broken
    shell.run(lua,doing)

end

function run()
    mprint("What do you wish to run?")
    mwrite("Note: type the whole command, like \n'>chat host Internet Link'\n>") --too lazy to check for args.
    shell.openTab(read())
end


Main()

-- cool thing: https://www.youtube.com/watch?v=cGufy1PAeTU

--noitsnotrickroll
--use the command 'update' for updates
