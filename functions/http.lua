--arg[1]==filename/filepath on the CC computer (default=nil (required))
--arg[2]==name/path on github (default=nil (required))
--arg[3]==user on github (default=Link-Jon)
--arg[4]==repo (default="CC-OSish")
--arg[5]==branch (default="master")
--arg[6]==print or save. (checks for "r" or "w") Read==print, write==save (default="2")

--required: arg1 and arg2. 
--if you put nil for 3, 4, 5, or 6 it will use default.
--for arg[2] if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]
os.loadAPI("mtext")
os.loadAPI("calc")
arg={}
function github(arg[1],arg[2],arg[3],arg[4],arg[5],arg[6]) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    if calc then
        calc.nilcheck(arg[4],"CC-OSish")
        calc.nilcheck(arg[5],"master")
        calc.nilcheck(arg[3],"Link-Jon")
        calc.nilcheck(arg[6],"w")
    end
    --ugh. translate \/ that into a single var... using string api more than likely. so i can test it XD
    if fs.exists(arg[1]) or arg[6]=="r" then
        --http.getResponse(url)
        local file = http.get("https://raw.githubusercontent.com/"..arg[3].."/"..arg[4].."/"..arg[5].."/"..arg[2])
        local f2 = file.readAll() -- all i need is the data. dont need the other stuff from the get request. or have anything else in the request either.
        if arg[6]=="w" then
                file.close()
                file.open(arg[1],"w")
                file.write(f2)
                file.close()
            elseif arg[6]=="r"
                mtext.mprint(f2)
        end
        else
            return(false)
    end
end




function printRes(url,bool)
    local file = http.get(url) -- should probably have this loop till it empties.. using ReadLine.
    raw=file.ReadAll()               -- IE slow print. so that a user can understand it.                 
    if bool==true or bool==nil then
        print(raw)
    end
    return(raw)
end

function ipcheck()
    ip=http.get("https://ipecho.net/plain")
    ip2=ip.readLine()
    ip3=http.get("https://api.hackertarget.com/reversedns/?q="..ip2)
    domain=ip3.readLine()
    return(ip2,domain)
end

function servercheck(ip,domain)
    MWL='?'
    MWLd='?' -- i dont have this ip yet..!
    Cosmic='95.216.32.202'-- wrong.
    Cosmicd=''


    if ip==MWL then
            mtext.mprint("\nLoaded onto MWL!\n") 
            perp=false
        elseif ip==Cosmic then
            mtext.mprint("\nLoaded onto Cosmic!\n") 
            perp=true
        else
            mtext.mprint("\nLoaded onto an Unknown Server!\n")
            mtext.mprint("IP: "..ip)
            mtext.mprint("Domain:"..domain)
    end
end
