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

function xOverTime(secs, xPerSec, xTotal)
    --xTotal if u want to find seconds instead of xTotal
    --secs= time waited in sec.
    --xPerSec= how much x you get each sec.
    --Also, if its something like 1 every 5sec, you need to convert into x/sec
    --Effectivly. (1 every 5 sec = 1/5=0.2)
    if xTotal then
        secs=xTotal/xPerSec
        times={}
        times[1]=secs--seconds
        times[2]=secs/60--minutes
        times[3]=(secs/60)/60--hours
        times[4]=((secs/60)/60)/24--days
        times[5]=(((secs/60)/60)/24)/7--weeks
        return(times)
    else
    local xTotal=xPerSec*secs
    return xTotal
    end
end
print(xOverTime(247,120))