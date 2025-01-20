--Todo
--Huh, incomplete scanner function.
--Infact, i dont have any wireless modem functions?
--odd.
--Well there is the chatter and chatlogger but those use chatbox.
--.. yeah the only one is the remote/controlled that is in progress.
--Weird.
--Anyway, this todo is actually to change my OTHER uses of http to use this version...
--atleast when from github? hmm i really dont know with this file.

--[[
-- ========== --
Local Wireless functions
(Wireless inside Minecraft.)
Or maybe generally modem functions. :P
-- ========== --
--]]

--need to make a transmitter
--with SOME level of encryption of some kind
--i dont really care how bad it is.
--im thinking just convert to binary function.

--... I need to fix WHERE my functions are.
-- ugh i hate how disorganized i am,
--but im too bad to fix it.
--[[
function scanner(channel,modem)
    if not modem then
        modem = peripheral.find('modem')
    end
    modem.open(channel)
    event, side, channel, rplyChannel, msg, distance = os.pullEvent("modem_message")
    --we dont need event, side, or channel.
    
    return rplyChannel, msg, distance
end
]]

function airTranscieveWire(wiredSide, wirelessSide, continuious, force)

    if continuious == nil then continuious = false end

    local wired = peripheral.wrap(wiredSide)
    local wireless = peripheral.wrap(wirelessSide)

    wired.open(rednet.CHANNEL_BROADCAST)
    wired.open(rednet.CHANNEL_REPEAT)
    wireless.open(rednet.CHANNEL_BROADCAST)
    wireless.open(rednet.CHANNEL_REPEAT)

    --input check
    --if input is backwards.
    if wired.isWireless() and not wireless.isWireless() and not force then
        local temp = wired
        wired = wireless
        wireless = temp
        temp = nil
    --if both same kind
    elseif wired.isWireless() == wireless.isWireless() and not force then
        return false, "Only Wireless AND Wired, not 2 of the same please."
    end

    repeat
        local event, side, channel, rplyChannel, msg, distance = os.pullEvent("modem_message")
        local msgStr

        if wired.isOpen(rplyChannel) == false then wired.open(rplyChannel) end
        if wireless.isOpen(rplyChannel) == false then wireless.open(rplyChannel) end

        --if i get a new rply channel, i need to open that channel...
        if type(msg) == "table" then
            msgStr = textutils.serialise(msg)
        else
            msgStr = tostring(msg)
        end
        write(os.clock()..": "..side.." ["..channel.."|"..rplyChannel.."]: "..msgStr.."\n")
        
        if side == wirelessSide then
            wired.transmit(channel, rplyChannel, msg)
        elseif side == wiredSide then
            wireless.transmit(channel, rplyChannel, msg)
        end

        if type(continuious) == "number" then
            continuious = continuious - 1
            if continuious <= 0 then continuious = false end
        end

    until continuious == false

end


function rednetChatLog()

    local modem = peripheral.find("modem")

    modem.open(rednet.CHANNEL_BROADCAST)
    --after checking, yeah its sending relay always. i can use this to find it...
    local log = fs.open("rednetChat.log","a")
    local name, compID, message, x, y

    while true do
        local event, side, channel, rplyChannel, msg, distance = os.pullEvent("modem_message")
        
        if type(msg) == "table" and msg.sProtocol == "chat" and msg.message.sType == "chat" then

            --We can either take the message from client, or server. Both however, would cause duplicates of everything, +1 per client connected...
            --Taking from client lets use see the ID it came from so.. lets do that.
            compID = rplyChannel
            x,y = string.find(msg.message.sText,".->")
            name = string.sub(msg.message.sText,x,y)
            message = string.sub(msg.message.sText,y+1,#msg.message.sText)

            log.write("["..name..", ID:"..rplyChannel..", dist:"..distance.."] "..message)
            term.write("["..name..", ID:"..rplyChannel..", dist:"..distance.."] "..message)
            log.flush()
        else
            if type(msg) == "table" then msg = textutils.serialise(msg) end
            term.print("UNSAVED: [rply/ID: "..rplyChannel..", dist: "..distance.."]"..msg)
        end
        
    end
    
    log.close()
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
logic = require("logic")


function github(arg1,arg2,arg3,arg4,arg5,arg6) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    --Check args that arent nessicary.
    --give them default values if nil
    arg3=logic.errcheck(arg3,"Link-Jon")
    arg4=logic.errcheck(arg4,"Link-CC")
    arg5=logic.errcheck(arg5,"master")
    arg6=logic.errcheck(arg6,"w")
    --Can be upgraded if i make errcheck()


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


function printRes(url,bool)
    local file = http.get(url) -- should probably have this loop till it empties.. using ReadLine.
    raw=file.ReadAll()               -- IE slow print. so that a user can understand it.                 
    if bool==true or bool==nil then
        print(raw)
    end
    return(raw)
end
--Need to see what this is doing
--Appears to be 'print Result' but that doesnt seem correct.


function ipcheck()
    local ip=http.get("https://ipecho.net/plain")
    local ip2=ip.readLine()
    local ip3=http.get("https://api.hackertarget.com/reversedns/?q="..ip2)
    static=ip3.readLine()
    return ip2, static
end

--[[
--i dont know if i will keep this because of the fact that i need to maintain it.
--its not easy to do. at all. its pain. cannot be done automatically i dont think
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
end]]

function time(offset)
    offset=calc.nilcheck(offset)
    local recieve=http.get("http://worldtimeapi.org/api/timezone")
end

return {}