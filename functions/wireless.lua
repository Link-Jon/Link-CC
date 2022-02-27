--[[
-- ========== --
Local Wireless functions
(Wireless inside Minecraft.)
Or maybe generally modem functions. :P
-- ========== --
--]]


--[[
function msgRecieve(channel)
    peripheral.find('modem')
end wut
]]


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

--[[
-- ========== --
Internet functions.
HTTP.lua, merged.
-- ========== --
--]]

--arg[1]==filename/filepath on the CC computer (default=nil (required))
--arg[2]==name/path on github (default=nil (required))
--arg[3]==user on github (default=Link-Jon)
--arg[4]==repo (default="CC-OSish")
--arg[5]==branch (default="master")
--arg[6]==print or save. (checks for "r" or "w") Read==print, write==save (default="2")

--required: arg1 and arg2.
--if you put nil for 3, 4, 5, or 6 it will use default.
--for arg[2] if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]
os.loadAPI("apiHandle.lua")


function github(arg1,arg2,arg3,arg4,arg5,arg6) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    arg3=calc.nilcheck(arg3,"Link-Jon")
    arg4=calc.nilcheck(arg4,"CC-OSish")
    arg5=calc.nilcheck(arg5,"master")
    arg6=calc.nilcheck(arg6,"w")

    if arg1 and arg2 then
        local file = http.get("https://raw.githubusercontent.com/"..arg3.."/"..arg4.."/"..arg5.."/"..arg2)
        local stringFile = file.readAll() -- all i need is the data. dont need the other stuff from the get request. or have anything else in the request either.
        if arg6=="w" then
            file.close()
            local temp=file.open(arg1,"w")
            temp.write(stringFile)
            temp.close()
            return stringFile
        elseif arg6=="r" then
            mtext.mprint(stringFile)
            return true
        end
    else return false end --whatever happened, failed. Good luck.
end
--[[
    This will be an absolute pain to make...
    Anywayyy here we go.
    First, because its easier to manage, you will need to give your args as an array/table
    args[1] = 
]]
function gitpost(args)

end
--... ugh.


function printRes(url,bool)
    local file = http.get(url) -- should probably have this loop till it empties.. using ReadLine.
    raw=file.ReadAll()               -- IE slow print. so that a user can understand it.                 
    if bool==true or bool==nil then
        print(raw)
    end
    return(raw)
end

function ipcheck()
    local ip=http.get("https://ipecho.net/plain")
    local ip2=ip.readLine()
    local ip3=http.get("https://api.hackertarget.com/reversedns/?q="..ip2)
    static=ip3.readLine()
    return ip2, static
end

function servercheck(dynamic,static)
    MWL='?'
    MWLd='?' -- i dont have this ip yet..!
    Cosmic='116.202.32.126' --wait these two ips are reversed?  strange.
    Cosmicd='126.32.202.116' 


    if string.find(static,MWLd) then
        mprint("\nLoaded onto MWL!\n") 
        perp=false
    elseif string.find(static,Cosmicd) then
        mprint("\nLoaded onto SiriusMC!\n")  --Note to self. Update ip adresses.
        perp=true
    else
        mprint("\nLoaded onto an Unknown Server!\n")
        mprint("Normal IP: "..dynamic)
        mprint("Static IP: "..static)
    end
end

function time(offset)
    offset=calc.nilcheck(offset)
    local recieve=http.get("http://worldtimeapi.org/api/timezone")
end