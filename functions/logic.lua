--calc. lib
if mtext==nil then
    mtext.print = print
    mtext.write = write
end

function timer(time)
    mtext.mwrite("Amount of time? in seconds.\n>")
    time=read()
    time=tonumber(time)
    min=convertTime(time)
        while time>0 do
            term.setCursorPos(1,1)
            if min>1 then
                mtext.mwrite("Minutes:"..min)
                term.setCursorPos(1,3)
            end
            mtext.mwrite("Seconds:"..time)
            term.clear()
            time=time-0.05
            min=min-0.05/60
            sleep(0.05)
            
        end --WARNING: minutes are not accurate...enough for me anyway
     term.clear()
     mtext.print("TIME OUT")
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
    local nilary = {'nil','null','',' '}
    local falseary = {'false','not','no',false}
    local trueary = {'t','true','yes',true}
    var=string.lower(tostring(var))
    if default and var==default then
        return var --check if default AND if default is nil
    end
    if var==nilary or var==nil then
        return nil --check if nil
    elseif var==trueary then
        return true --check if true
    elseif var==falseary then
        return false --check if false
    else --if none of the above, return var.
        return var
    end
end --NOTE: CHANGE IF--ELSE to switch() once switch() has been built!!

function xPerSec(amount, interval)
    return amount/interval
end

function xOverTime(secs, xPerSec, xTotal)
    --xTotal if u want to find seconds instead of xTotal
    --secs= time waited in sec.
    --xPerSec= how much x you get each sec.
    --Also, if its something like 1 every 5sec, you need to convert into x/sec
    --Effectivly. (1 every 5 sec = 1/5=0.2)
    if xTotal then
        secs=xTotal/xPerSec
        local times={}
        times[1]=secs   --seconds
        times[2]=secs/60     --minutes
        times[3]=(secs/60)/60     --hours
        times[4]=((secs/60)/60)/24    --days
        times[5]=(((secs/60)/60)/24)/7  --weeks
        return times
    else
        local xTotal=xPerSec*secs
        return xTotal
    end
end

--num1/2 are just inputs.
--act is how to compare num1 and 2. 
--Also while switch is made to get rid of most other elseif walls, it does contain a few..
--arry, is the biggest part of this function.
--Anddd the most painful. It will be an a array... of functions. that you give into switch
--for switch to determine what function to use. Be sure to use simpler functions, espesially when you have alot.
--equal is a bool; setup for equal to. if true, then if > or <, it will add (or subtract, depending on comparison direction)
--1 to num2 to emulate an equal-to. (instead of new inlines for >= and <=)
function switch(num1,num2,arry,act,equal)
    types = {type(num1),type(num2),type(arry)}

    if types[1] == "table" and types[2]=="number" and types[3] == "table" or types[1]=="table" and types[2] == "string" and types[3] == "table" then
        if #num1 < #arry then --Note; #table gives table length
            error("(switch()) num1's array must be longer than the function arry! (ideally they should be the same length...)")
        end

        if types[2]==string then
            act = "str"
        elseif not act then
            act = ">"
        end -- when we dont have a string from act, or num2 is a string, thus doing this...

        --^ sets act to "str" if num2 is a string, just incase our input didnt.
    --phew!! Error handling is DONE!! YAY! XD (|except i just erased all my work due to deciding numbers are not needed. :(|)
    
    -- doing '>'
        if act == ">" then
        for i=1,#num1 do
            if num1[i] > num2 then
            arry[i]()
            end
        end
        
    -- '<'
        elseif act == "<" then
        for i=1,#num1 do
            if num1[i] < num2 then
            arry[i]()
            end
        end
    -- '='
        elseif act == "=" or act == "str" then
        for i=1,#num1 do
            if num1[i] == num2 then
            arry[i]()
            end
        end
    -- '~' (Not equal)
        elseif act == "~" then
        for i=1,#num1 do
            if num1[i] ~= num2 then
            arry[i]()
            end
        end
        end
    else
        error("Wrong variables were input! Check the switch() call!")--
    end
end
