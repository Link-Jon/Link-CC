--[[
function binary()
    mtext.mprint("Warning. Do not use more than one byte. (8 bits or 255 in dec)")
    mtext.mprint("Start value binary or decimal?")
    mtext.mprint("B / D \n>")
    input=read()
    
    if input=="B" then
        byte = {0,0,0,0,0,0,0,0}
        loop=1
        mtext.mprint("Input the number as a byte, from left to right.")
        mtext.mprint("Eg. 00001111 == 16, you can type 00001111.\n>")
        while loop>8 true
            byte[loop]=read()
            loop=loop+1
        end
    elseif input=="D" then
        mtext.mprint("Input the decimal number\n>")
        input=read()
        --MUCH easier to do...
end

function testbin()
    mtext.mprint("Warning. Do not use more than one byte.")
    mtext.mprint("Start value binary or decimal?")
    mtext.mprint("B / D \n>")
    input=read()
    
    if input=="B" then
        mtext.mprint("Input the number like this: 16 == 00001111\n>")
        dec=tonumber(read(),10)
        mtext.mprint(dec)
        return(dec)
    elseif input=="D" then
        mtext.mprint("Input the decimal number\n>")
        byte=tonumber(read(),2)
        return(byte)
end
]]--

test=load("10*60")
print(test)