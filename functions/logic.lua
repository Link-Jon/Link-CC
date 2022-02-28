--calc. lib
function timer(time)
    mtext.mwrite("Amount of time? in seconds.\n>")
    time=read()
    time=tonumber(time)
    min=convertTime(time)
        while time>0 do
            term.setCursorPos(1,1)
            if min>1 then
                mtext.mwrite("Minutes:"..min)
            end
            term.setCursorPos(1,3)
            mtext.mwrite("Seconds:"..time)
            term.clear()
            time=time-0.05
            min=min-0.05/60
            sleep(0.05)
            
        end--WARNING: minutes are not accurate...enough for me anyway
     term.clear()
     print("TIME OUT")
end

function convertTime(time)
    time=time/60
    return time
end

function calc()
    mtext.mwrite("First number:")
    numa=read()
    mtext.mprint("What type of calculation")
    mtext.mwrite("M / D / A / S\n>")
    fun=read()
    mtext.mwrite("Second number:\n>")
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

function nilcheck(var, default)
    local nilary = {'nil','Nil','NIL','NULL','null','Null','',' '}
    if var==nilary then
        if not default then
                var=nil
            else
                var=default
        end
    end
    return(var)
end

function xOverTime(secs, xPerSec, xTotal)
    --xTotal if u want to find seconds instead of xTotal
    --secs= time waited in sec.
    --xPerSec= how much x you get each sec.
    --Also, if its something like 1 every 5sec, you need 0.5 (check after function is built)
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
    return(xTotal)
    end
end
