function mprint(str)
    if monitors==true then
            local loop=loop+1
            local x,y =mon.getCursorPos()
            y=y+1
            if loop==5 then
                mon.scroll(5)
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

function mwrite(str)
    if monitors==true then
        --loop=loop+1 nah
        local temp=term.current()
        term.redirect(mon)
        write(str)

        term.redirect(temp)
        write(str)
        return
    else
        write(str)
        return
    end
end



function mclear()
    if monitors==true then
        local temp=term.current()
        term.redirect(mon)
        clear()

        term.redirect(temp)
        clear()
        return
    else clear(); return
    end
end

function msetCursorPos(x,y)
    if monitors==true then
        local temp=term.current()
        term.redirect(mon)
        term.setCursorPos(x,y)

        term.redirect(temp)
        term.setCursorPos(x,y)
        return
    else
        term.setCursorPos(x,y)
        return
    end
end

function montest()
        if mon~=nil then
            mwrite("Use the connected Monitor?\n Warning: This file is not very well built for a monitor\n (y/n)\n>")--it isnt. working on that now...
            if read()=="y" then
                    monitors=true
                    mon.setTextScale(0.5)
                    mon.clear()
                    mon.setCursorPos(1,1)
                else
                    mwrite("\nImpromper input or input was no\n")
            end
        end
end
