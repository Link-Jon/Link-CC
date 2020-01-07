function LPmonitor()
    block= {"Stats-Table","Security Station"}

    count=1
    max=3 --equals one higher than how many blocks you will wrap.
    mprint("NOTE: made for people that understand CC more.")
    if perp==true then
        mprint("LAN or network cables?")
        mwrite("LAN / NET\n>")
        LPINPUT=read()
        if LPINPUT=="LAN" then
                mprint("not yet implemented")
            elseif LPINPUT=="NET" then
        end
    end
    
    mprint("\nIf unused type 'nil' \n If placed next to the computer type the side it's connected to \n I am looking for the modem's 'name' that it gives when you turn it on")
    while count<max do
        mwrite(block[count].." Name?\n>")
        block[count]=read()
        nilcheck(block[count])
        count=count+1
    end

    while count>0 do
        peripheral.wrap(block[count])
        count=count-1
    end

    while exitvar==true do
    end
        
end
