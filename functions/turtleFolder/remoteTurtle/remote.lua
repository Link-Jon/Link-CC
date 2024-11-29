--Todo
--Why is this the third time im writing this script.
--sigh.
--Anyway, works with controlled.lua to send functions to turtles.
--more details in controlled.lua.

--... this file is far more completed, too.



--give turtle enderchest to dump/interact to/with base???
--very cool, but can do it later...
--hooks to a turtle using the remoteControl script

modem = peripheral.find("ender_modem")

if not modem then
    print("Warning! no ender modem found, range will be EXTREMELY limited.")
    modem = peripheral.find("wireless_modem") --these names may or may not work

    if not modem then
        error("No wireless modem detected.")
    end
end

--lets go.
--we need to either be sending a ping, or replying to a ping with a pong.
--This remote half is likely to be the one  restarted often, so THIS should send the ping.

--[[
modem api refrence

local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(43) -- Open 43 so we can receive replies

-- Send our message
modem.transmit(15, 43, "Hello, world!")

-- And wait for a reply
local event, side, channel, replyChannel, message, distance
repeat -- this is a while loop, in reverse.
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 43

print("Received a reply: " .. tostring(message))
]]

modem.open(54)

while event == nil do
    modem.transmit(55, 54, "turtleping")

    --ping for turtle every 15 seconds
    parallel.waitForAny(
        function()
            repeat
            event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
            until msg == "turtlepong"
        end,

        function()
            sleep(15)
        end
    )
end

_remoteActive_ = true

term.clear()
print("Remote Turtle Active!")

while _remoteActive_ do

    --[[term handler
    term.setCursorPos(1,1)
    term.write("")
    --]]
SOS = parallel.waitForAny(
    function() --This is always going to be an SOS call from the turtle
        event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
        return msg
    end,

    function()
        term.write("CC> ")
        functionToSend = io.read()
        
        modem.send(functionToSend)
        return nil
    end)
    
    if SOS then
        printError("Turtle sent SOS!")
        error(SOS)
    else

        repeat
        
            event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
            
            print("Turtle sent:"..textutils.serialize(msg))

        until msg == {"completed",functionToSend} 

    end

    --send
end