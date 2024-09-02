--NOTE: Fix for multiversion. (1.7.10 and 1.12 notably (1.12 is also very simalar to updated versions beyond it.))

os.loadAPI(".system/notes")
print("loaded notes")

os.loadAPI(notes.dir.."mtext")
os.loadAPI(notes.dir.."help")
os.loadAPI(notes.dir.."https")
os.loadAPI(notes.dir.."calc")

if fs.exists("sys/bluenet") then --functions/wireless
    bluenet=os.loadAPI("sys/bluenet")
end

if fs.exists("") then
    os.loadAPI("")
end
    BASIC = {"chat", "discord", "functions", "help", "ls", "list"}
    SHELL = {"clear", "exit", "reboot", "run"}
    MATH = {"math", "timer"}
    HTTP = {"license"}
    USERFUN = {BASIC, HTTP, MATH, SHELL} --Hey its a namespace LUL

    --a thing to hold all accessable functions from my libs.
    Functions = {
        logic="logic",
        help="help",
        system_notes="notes",
        bluenet="wireless",
    }


function dolua(inputb, user)
    --basic array for function list...
    --nvm this is going to get complicated quick. Also, user only. not raw functions.
    --Yeah... Update to switch. is... very needed.


    if inputb==USERFUN[1] then --note, make an array for the help list. maybe make it its own file too.
        help.help()
        
    elseif inputb=="chat" then 
        if not bluenet then
            if not http then
                mprint("This function requires an undownloaded library and HTTP is inacessable")
            end
                mprint("Warning; This function requires an undownloaded library. Download now?")
                mwrite(" y / n ")
                input=read()
                if string.lower(input)=='y' then
                    github(system_notes.dir,'function/wireless')
                    bluenet.Internet()
                elseif string.lower(input)=='n' then
                    mprint("Aborting.")
                else
                    mprint("Unknown input")
                end

            elseif fs.exists("bluenet") then
                bluenet.Internet()
            else
                permerr()
            end

    elseif inputb=="exit" then 
        if user>=2 then
                error("Process forcefully ended")
            else
                os.shutdown()
        end
        
    elseif inputb=="run" then 
        if user>=1 then
            mprint("What do you wish to run?")
            mwrite("Note: type the whole command, like \n'>chat host Internet Link'\n>") --too lazy to check for args.
            shell.openTab(read())
        else
            permerr()
        end
         

    elseif inputb=="reboot" then 
        os.reboot()
                            
    elseif inputb=="clear" then
        term.clear()
        term.setCursorPos(1,1)

    elseif inputb=="timer" then
        if monitors then
            mon.clear()
            timer()
            mon.clear()
		else
			timer()
		end

    elseif inputb=="math" then
        shell.openTab(calc.calc())

    elseif inputb=="function" then 
        if user>=1 then
            shell.openTab(dofun())
        else
            permerr()
        end

    elseif inputb=="logistic" then
        LPmonitor()
	elseif inputb=="license" then
        github("","",nil,nil,nil,"r")
    elseif inputb=="list" or inputb=="ls" then
        print("")
    else
        printError("Not a viable input")
    end
end

function permerr()
    mtext.mprint("WARNING: INSUFFICIENT PERMMISIONS\n YOUR LEVEL: "..user.."\n>")
end
--goal of detecting and erroring when an incorrect input type is given
function inErr(user,check)
    local str=type(user)
    if str==check then
        return true
    end
    --massive input err checker
    --could probably be simplified but would lose unique reactions.
    if str=="string" then
        printError("Expected "..check..", got string")
    elseif str=="nil" then
        printError("Expected "..check..", got nil")
    elseif str=="bool" then
        printError("Expected "..check..", got bool")
    elseif str=="number" then
        printError("Expected "..check..", got number")
    elseif str=="table" then
        printError("Expected "..check..", got table")
    elseif str=="function" then
        printError("Expected "..check..", got function")
    elseif str=="thread" then
        printError("Expected "..check..", got thread")
    elseif str=="userdata" then
        printError("How in the world have you done this? Var was of type userdata, which should be impossible in CraftOS")
        printError("Expected "..check..", got userdata??")
    else
        printError("Something broke with the 'inErr' function.")
        printError("Expected "..check..", got "..str)
    end
    return false
end