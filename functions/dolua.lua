function dolua(inputb)
    if inputb=="help" then --note, make an array for the help list. maybe make it its own file too.
            help()
        
        elseif inputb=="chat" then 
            if user>=1 then
                    Internet()
                else
                    permerr()
            end

        elseif inputb=="exit" then 
            if user>=2 then
                    error("Process ended")
                else
                    os.reboot()
            end
        
        elseif inputb=="run" then --idc
            if user>=1 then
                    run()
                else
                    permerr()
            end
            
        elseif inputb=="discord" then 
            discord()

        elseif inputb=="reboot" then 
            os.reboot()
                            
        elseif inputb=="clear" then
            term.clear()

        elseif inputb=="timer" then
            if monitors then
                    mon.clear()
                    timer()
                    mon.clear()
				else
					timer()
			end

        elseif inputb=="math" then
            shell.openTab(calc())

        elseif inputb=="function" then 
            if user>=1 then
                    shell.openTab(dofun())
                else
                    permerr()
            end

        elseif inputb=="logistic" then
            LPmonitor()
		elseif inputb=="license" then
			github(license,license,nil,nil,nil,"r")
end

function dofun()
    mwrite("\nType the EXACT name of the function\n>")
    doing=read()--warning broken
    shell.run(lua,doing)
end
