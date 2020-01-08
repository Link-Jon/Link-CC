--arg[1]==filename/filepath on the CC computer (default=nil (required))
--arg[2]==name/path on github (default=nil (required))
--arg[3]==user on github (default=Link-Jon)
--arg[4]==repo (default="CC-OSish")
--arg[5]==branch (default="master")
--arg[6]==print or save. (checks for "r" or "W") Read==print, write==save (default="W")

--required: arg1 and arg2. 
--if you put nil for 3, 4, or 5 it will use default.
--for arg[2] if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]
function github(arg[1],arg[2],arg[3],arg[4],arg[5],arg[6]) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    if nilcheck then
        nilcheck(arg[4],"CC-OSish")
        nilcheck(arg[5],"master")
        nilcheck(arg[3],"Link-Jon")
        nilcheck(arg[6],"w")
    end
    --ugh. translate \/ that into a single var... using string api more than likely. so i can test it XD
    if fs.exists(arg[1]) or arg[6]=="r" then
        --http.getResponse(url)
        local file = http.get("https://raw.githubusercontent.com/"..arg[3].."/"..arg[4].."/"..arg[5].."/"..arg[2])
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

function printRes(url)
    local count --wanted count to be local
    --for count do
    local file = http.get(url) -- should probably have this loop till it empties.. using ReadLine.
    file.ReadAll               -- IE slow print. so that a user can understand it.
    --sleep(1)  Count needs to check 'file' for how many more lines left...
    --end
    return
end
