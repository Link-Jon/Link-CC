os.loadAPI("mtext")
os.loadAPI("calc")

--[[

--- Local Modem Handles ---

]]--

function msgGet(channel,modem)
    if not modem then
        modem = peripheral.find('modem')
    end
    modem.open(channel)
    event, side, channel, rplyChannel, msg, distance = os.pullEvent("modem_message")
    --we dont need event, side, or channel.
    
    return rplyChannel, msg, distance
end


function Internet()
    local CN="string"
    local name="string"
    local style="string"

    term.clear()
    mtext.msetCursorPos(1,1)
    mtext.mwrite("\nWhat kind of internet do you want (host/client)\n>")
    mtext.msetCursorPos(1,2)
    style=io.read()
    if style=="join" then
        mtext.mwrite("What is the name of the chat? \n>")
        mtext.msetCursorPos(1,4)
        CN=io.read()

        mtext.mwrite("What shall you be called? \n>")
        mtext.msetCursorPos(1,6)
        inname=io.read()

        shell.openTab("chat join "..CN.." "..inname)
    elseif style=="host" then
        mtext.mwrite("What will be the name of the chat?\n>")
        mtext.msetCursorPos(1,4)
        CN=io.read()

        shell.openTab("chat host "..CN)
    end
end

--Note to self: Make a double-terminal chat via mtext. 
--AKA copy/paste chat program and add mtext commands EVERYWHERE
--Would be a pretty heavy file, so would want it to be an optional download...


--[[

--- HTTP ---

]]--



--arg[1]==filename/filepath on the CC computer (default=nil (required))
--arg[2]==name/path on github (default=nil (required))
--arg[3]==user on github (default=Link-Jon)
--arg[4]==repo (default="CC-OSish")
--arg[5]==branch (default="master")
--arg[6]==print or save. (checks for "r" or "w") Read==print, write==save (default="2")

--required: arg1 and arg2. 
--if you put nil for 3, 4, 5, or 6 it will use default.
--for arg[2] if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]

function github(arg1,arg2,arg3,arg4,arg5,arg6) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    if calc then
        calc.nilcheck(arg4,"CC-OSish")
        calc.nilcheck(arg5,"master")
        calc.nilcheck(arg3,"Link-Jon")
        calc.nilcheck(arg6,"w")
    end
    --ugh. translate \/ that into a single var... using string api more than likely. so i can test it XD
    if fs.exists(arg1) or arg6=="r" then
        --http.getResponse(url)
        local file = http.get("https://raw.githubusercontent.com/"..arg3.."/"..arg4.."/"..arg5.."/"..arg2)
        local f2 = file.readAll() -- all i need is the data. dont need the other stuff from the get request. or have anything else in the request either.
        if arg6=="w" then
                file.close()
                file.open(arg1,"w")
                file.write(f2)
                file.close()
            elseif arg6=="r" then
                mtext.mprint(f2)
        end
        else
            return(false)
    end
end

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
    Cosmic='116.202.32.126'
    Cosmicd='126.32.202.116'


    if string.find(static,MWLd) then
            mtext.mprint("\nLoaded onto MWL!\n") 
            perp=false
        elseif string.find(static,Cosmicd) then
            mtext.mprint("\nLoaded onto SiriusMC!\n") 
            perp=true
        else
            mtext.mprint("\nLoaded onto an Unknown Server!\n")
            mtext.mprint("Normal IP: "..dynamic)
            mtext.mprint("Static IP: "..static)
    end
end
