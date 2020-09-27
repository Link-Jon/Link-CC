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
    term.mwrite("\nWhat kind of internet do you want (host/client)\n>")
    term.setCursorPos(1,2)
    style=io.read()
    if string.lower(style)=="client" then
            term.mwrite("What is the name of the chat? \n>")
            term.setCursorPos(1,4)
            CN=io.read()

            term.mwrite("What shall you be called? \n>")
            term.setCursorPos(1,6)
            inname=io.read()
            shell.openTab("chat join "..CN.." "..inname)
            --while i could build a string like this, assign it to a var,
            --then use load(), then use the function it gives, this is faster.
        elseif string.lower(style)=="host" then
            term.mwrite("What will be the name of the chat?\n>")
            term.setCursorPos(1,4)
            CN=io.read()
            shell.openTab("chat host "..CN)
    end
end
