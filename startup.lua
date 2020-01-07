
mon=peripheral.find("monitor")
perp=false --Immibis peripherals  (gets checked with server)
loop=0
name=="Link"
exitvar=true --just incase i may ever use it...
function Main()
	git("functions/help.lua","help")
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
    local input=read("*")
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

    servercheck(ipcheck())

    while exitvar do
		if user>=2 then
			mprint("Welcome back "..name.."!")
		end
        mwrite("What do you want to do? (help for list)\n>")
        local inputb=read()
   
        if inputb=="help" then --note, make an array for the help list. maybe make it its own file too.
			help()
   
            elseif inputb=="chat" then --move. make more friendly.
                if user>=1 then
                    		Internet()
                	else
                    		permerr()
                end

            elseif inputb=="exit" then --keep here
                if user>=2 then
                        error("Process ended")
                    else
                        os.reboot()
                end
        
            elseif inputb=="run" then --idc
                if user>=1 then
                        run()
                    else
                        permerr()
                end
            
            elseif inputb=="discord" then -- new file. merge the two discord functions.
                discord()
            
            --elseif inputb=="disk" then    -to be remade with a full updater.
            mwrite("\nHow is the disk connected \n IE 'left','right'.'top', ect\n>")
            shell.run("label set")
            file=fs.open(disk/update)
            file.mwrite(" fs.delete('startup')")
            file.mwrite("shell.run(pastebin get 7W48dz3c startup)")
            file.mwrite("shell.run('startup')")
            file.close()

            elseif inputb=="reboot" then -- keep here
                os.reboot()
                
            elseif inputb=="clear" then -- keep here.
                term.clear()

            elseif inputb=="timer" then -- put this extra code into the timer file also..
				timer()

            elseif inputb=="math" then -- new file
                shell.openTab(calc())

            elseif inputb=="function" then -- new file
                if user>=1 then
                        shell.openTab(dofun())
                    else
                        permerr()
                end

            elseif inputb=="logistic" then --allready seperated.
                LPmonitor() -- maybe tier one..?

        end
    end
end
 
function permerr()
    mprint("WARNING: INSUFFICIENT PERMMISIONS\n")
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
    
function ipcheck()
    ip=http.get("https://ipecho.net/plain")
    ip2=ip.readLine()
    ip3=http.get("https://api.hackertarget.com/reversedns/?q="..ip2)
    domain=ip3.readLine()
    return(ip2,domain)
end

function servercheck(ip,domain)
    MWL='?'
    MWLd='?' -- i dont have this ip yet..!
    Cosmic='95.216.32.202'
    Cosmicd=''


    if ip==MWL then
            mprint("\nLoaded onto MWL!\n") --LAGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
            perp=false
        elseif ip==Cosmic then
            mprint("\nLoaded onto Cosmic!\n") -- favourite.
            perp=true
        else
            mprint("\nLoaded onto an Unknown Server!\n")
            mprint("Domain:"..domain)
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

function discord()
    mprint("Join the discord that i for some reason made for this file!")
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

-- cool thing: https://www.youtube.com/watch?v=cGufy1PAeTU

--noitsnotrickroll
--use the command 'update' for updates
