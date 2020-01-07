--arg[1]==filename/filepath on the CC computer
--arg[2]==name/path on github
--arg[3]==user on github
--arg[4]==repo
--arg[5]==branch
--arg[6]==print or save. (checks for "r" or "W") Read==print, write==save

--required: arg1 and arg2. 
--if you put nil for 3, 4, or 5 it will use default.
--for arg[2] if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]
function github(arg[1],arg[2],arg[3],arg[4],arg[5],arg[6]) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    nilcheck(arg[4],"CC-OSish")
    nilcheck(arg[5],"master")
    nilcheck(arg[3],"Link-Jon")
    nilcheck(arg[6],"w")
    --ugh. translate \/ that into a single var... using string api more than likely. so i can test it XD
      ("https://raw.githubusercontent.com/"..arg[3].."/"..arg[4].."/"..arg[5].."/"..arg[2])
    if fs.getDir(arg[1]) or arg[6]=="r" then
        http.getResponse()
        local file = http.get(url)
        local f2 = file.readAll() -- all i need is the data. dont need the other stuff from the get request. or have anything else in the request either.
        if arg[6]=="W" then
                file.close()
                file.open(arg[1],"w")
                file.write(f2)
                file.close()
            elseif arg[6]=="r"
                mprint(f2)
        end
        else
            return(false)
    end
end

function htest(url) -- very basic. will change.
    
    return(http.getResponse(url))
    
end
