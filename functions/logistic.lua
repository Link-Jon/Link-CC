function LPmonitor()
    local block= {"sTable","Security Station"}
    local LPBlock="logisticsSolidBlock-"
    local count=1
    local max=3 --equals one higher than how many blocks you will wrap.
    mtext.mprint("NOTE: made for people that understand CC more.")
        
    mtext.mprint("\nIf unused type 'nil' \n I am looking for the modem's 'number' that it gives when you turn it on")
    while count<max do
        mwrite(block[count].." Number?\n>")
        block[count]=read()
        nilcheck(block[count])
        count=count+1
    end

    while count>0 do
        peripheral.wrap(block[count])
        count=count-1
    end
        
end
--ugh i hate this