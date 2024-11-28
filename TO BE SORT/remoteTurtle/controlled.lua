modem = peripheral.find("wireless_modem")
APIList = {"logic","dwarfAPI"}

if not modem and not then
    modem = peripheral.find("wireless_modem") --these names may or may not work

    if not modem then
        error("No wireless modem detected.")
    end
end

modem.open(55)

repeat
    event, side, channel, reply, msg, dist = os.pullEvent("modem_message")
until reply == 54 and msg == "turtleping"

modem.transmit(54, 55, "turtlepong")
_remoteActive_ = true

while true do
    break -- temp ending, remove when making real function
    --recieve the code, ping that it was recieved,
    --do the code, and every 30 ish seconds send an update to the
    --remote. if we cannot, tell the remote we will ping when done
    --or SOS
end