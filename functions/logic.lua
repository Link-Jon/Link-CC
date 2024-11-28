--logic. lib? yeh.

function nilcheck(var, default)
    local nilary = {'nil','null','',' '}
    local falseary = {'false','not','no',false}
    local trueary = {'t','true','yes',true}

    
    var=string.lower(tostring(var)) --convert to string to test, and lowercase the string
    if var==default then
        return var          --check if var is default
    end

    for i = 1,4 do
        
    if var==nilary or var==nil then
        return nil          --check if nil
    elseif var==trueary then
        return true         --check if true
    elseif var==falseary then
        return false        --check if false
    end
       --if none of the above, return var. 
    return var
end --Nvm... switch... is really just unneeded to have here.


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
end --How could i have the functionallity of xPerSec implanted into this function...?



--act is how to compare num1 and 2.
--arry is to be an array of lua chunks, the same arry length as num1. Or only one function/chunk that will execute if a true is found
--for switch to determine what function to use. Be sure to use simpler functions, espesially when you have alot.
--equal is a bool; setup for equal to. if true, then if > or <, it will add (or subtract, depending on comparison direction)
--1 to num2 to emulate an equal-to. (instead of new inlines for >= and <=) (assumed false)

--This may be able to be made functional with the power of for loops?
--I'll need to look into this later...
--for now and as long as it has been here, its been easier to just make the if statement yourself.

--Needs to be updated to use multithreading.
function switch(num1,num2,arry,act,equal)
    types = {type(num1),type(num2),type(arry)}

    if types[1] == "table" and types[2]=="number" and (types[3] == "table" or types[3] == "function") or types[1]=="table" and types[2] == "string" and (types[3] == "table" or types[3] == "function") then
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
    
    -- equalto setup
        if equal then
            if act == ">" then
                num2=num2-1
            elseif act == "<" then
                num2=num2+1
        end;end

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
        end;end
    else
        error("Wrong variables were input! Check the switch() call!")
    end
end


--mtext functions. These exist to write to both the monitor AND the main screen at the same time.
function mprint(str) --for now i will assume i didnt just redirect and print for a reason, but i will come back to this later...
                     --currently, just merging files :P (wait does print exist while term=mon? not sure.)
    if monitors==true then
        local loop=loop+1
        local x,y =mon.getCursorPos()
        y=y+1
        if loop==5 then
            mon.scroll(5) --need to keep the text visible
            y=1
            loop=0
        end
        mon.setCursorPos(1,y)
        mon.write("\n"..str.."\n")
        print(str)
        return
    else
        print(str)
        return
    end
end
--both works?
function mwrite(str,scroll)
    if monitors==true then
        local temp=term.current()   --save current terminal, dont want to lose it!
        term.redirect(mon);     write(str)  --redirect and write line
        if type(scroll=="number") then
          term.scroll(scroll); end  --scrolls line count 'scroll' (arg2)

        term.redirect(temp);    write(str)
        if type(scroll=="number") then
          term.scroll(scroll); end
        return
    else
        write(str)
        return
    end
end

function montest()
    if mon then
        --Maybe better to say 'double the output to the connected monitor'
        mwrite("Use the connected Monitor?\n Warning: This 'program' is not very well built for a monitor\n (y/n)\n>")
        if nilcheck(read(),true)==true then
            _MONITORS_=true
            mon.setTextScale(0.5)
            mon.clear()
            mon.setCursorPos(1,1)
        else
            mwrite("\nImpromper input or input was no\n")
        end
    end
end

    --actually. i should REALLY just make it work in some way,
    --before asking how it should work if i cannot make a decision on it...
--err({x,y,z,...})
function errcheck(value, defVal, defType, conform, die)
    --value = var to be checked
    --conform = a list of alternitive 'defaults', they are all humanly
        --the same value (like 'f' and 'false' and false) but they are technically different 

    
    --Check default and nil
    if value == defVal then
        return value, true
    elseif value == nil then
        if die then
            print("Errcheck got nil, and 'die' bool was enabled")
            error("errcheck(nil, "..defVal..", "..nilcheck(defType)..", "..nilcheck(conform)..", true")
        else
            print("Warn: Errcheck got nil. ('die' not enabled, continuing)")
            print("errcheck(nil, "..defVal..", "..nilcheck(defType)..", "..nilcheck(conform)..", false")
            return value, false
        end
    end
    
    if conform ~= nil and type(conform) ~= "array" then
        error("Conform (arg4) must be an array! (Even if an array of 1 value)")
    end

    --should i nilcheck(value)..?

    for i,v in pairs(conform) do
        if value == v then
            returnVal = defVal
            break
        end

    if die and returnerVal==nil then
        error("Expected "..type..", got "..value, 1)
    end

end 
-- i know this was sposed to be really helpful with error handlin, and more so debugging, but idk what i wanted to make so...
-- Hi me, now i do. :D

return { 
    nilcheck = nilcheck, 
    switch = switch,
    mtext = {
        print = mprint,
        write = mwrite,
        montest = montest},
    xOverTime = xOverTime
}