--Todo
--Alot of the stuff here is really specific and from when i started making this
--in tekkit legends. (MC = 1.7.10)
--So. Not sure what to do with it atm. The user functions are nice though, 
--and should be upgraded to be actually usable again

--require(".system/notes")
--logic = require(notes.dir.."logic.lua")

--Login script from startup.lua
function login()

    --backup, just incase. also for more complex code :/ oh well.
    pullBack = pullEvent
    osPullBack = os.pullEvent
    rawBack = os.pullEventRaw
    --disable events...
    
    os.pullEvent = os.pullEventRaw
    
    term.clear()
    term.setCursorPos(1,1)
    montest()
    
    local pass = {'not','getting','mypass'} --  :P
    
    if pocket then-- because its not \/
        mprint("WARNING: NOT OPTIMIZED FOR POCKET COMPUTERS")
    end
    
    mtext.mwrite("Enter Password: ")
    local input=read("*")
    if input==pass[1] then
            mprint("WARNING: SIGNED IN AS GUEST. RESTRICTIONS ENABLED")
            user = 0 --note; user=0 is guest, user=1 is a friend, user=2 is main
            sleep(2)
        elseif input==pass[3] then
            mprint("NOTICE: SIGNED IN AS FRIEND. PARTIAL RESTRICTION ENABLED")
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
    
end

--Simple timer that is displayed. Runs on gametime instead of deltatime;
--So if it lags, it will slow down.
function timer(time)
    mwrite("Amount of time? in seconds.\n>")
    time=tonumber(read())
    min=time/60
        while time>0 do
            term.setCursorPos(1,1)
            if min>1 then
                mwrite("Minutes:"..min)
                term.setCursorPos(1,3)
            end
            mwrite("Seconds:"..time)
            term.clear()
            time=time-0.05
            min=min-0.05/60
            sleep(0.05)
            
        end --WARNING: minutes are not accurate...enough for me anyway
     term.clear()
     mprint("TIME OUT")
end


--Basic calculator, 
--Should be upgraded so it just
--processes a given  mathematic formula.
    --todo: just... run the input formula with lua?
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


--Literally just uses CC's 'chat' program
function Internet()
    local CN="string"
    local name="string"
    local style="string"

    term.clear()
    term.setCursorPos(1,1)
    mwrite("\nWhat kind of internet do you want (host/client)\n>")
    term.setCursorPos(1,2)
    style=io.read()
    if string.lower(style)=="client" then
        mwrite("What is the name of the chat? \n>")
        term.setCursorPos(1,4)
        CN=io.read()

        mwrite("What shall you be called? \n>")
        term.setCursorPos(1,6)
        uname=io.read()
        shell.openTab("chat join "..CN.." "..uname)
        --while i could build a string like this, assign it to a var,
        --then use load(), then use the function it gives, this is faster.
    elseif string.lower(style)=="host" then
        mwrite("What will be the name of the chat?\n>")
        term.setCursorPos(1,4)
        CN=io.read()
        shell.openTab("chat host "..CN)
    end
end

--function ()

--end

return {
    login = login,
    timer = timer,
    calc = calc,
    internet = internet
}