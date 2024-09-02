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

return {login = login}