function mprint(str)
    if monitors==true then
            loop=loop+1
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

function mwrite(str)
    if monitors==true then
            loop=loop+1
            local x,y=mon.getCursorPos()
            y=y+1
            if loop==5 then
                mon.scroll(5)
                y=1
                loop=0
            end
            mon.setCursorPos(1,y)
            mon.write(str)
            write(str)
            return
        else
            write(str)
            return
    end
end
