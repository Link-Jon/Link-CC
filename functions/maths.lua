
function timer(time)
    mwrite("Amount of time? in seconds.\n>")
    time=read()
    time=tonumber(time)
    min=convertTime(time)
        while time>0 do
            term.setCursorPos(1,3)
            term.clear()
            mwrite("Seconds:"..time)
            term.setCursorPos(1,1)
            if min>1 then
                mwrite("Minutes:"..min)
            end
            time=time-0.1
            min=min-0.1/60
            sleep(0.1)
        end--WARNING: minutes are not accurate...enough for me anyway
     term.clear()
     print("TIME OUT")
end

function convertTime(time)
    time=time/60
    return(time)
end

function calc()
    mwrite("First number:")
    numa=read()
    mprint("What type of calculation")
    mwrite("M / D / A / S\n>")
    fun=read()
    mwrite("Second number:\n>")
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
    return(var)
end
