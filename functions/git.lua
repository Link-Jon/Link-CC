--arg1==filename/filepath on the CC computer, 2==name/path on github, 3==user on github, 4==repo, 5==branch.
--required: arg1 and arg2. if you put nil for 3, 4, or 5 it will use default.
--for arg 2, if its inside a file like /functions/git.lua you need to input "foldername/filename" for arg[2]
function github(arg[1],arg[2],arg[3],arg[4],arg[5]) --note. lua arrays start at 1, not 0. (changeable, but i'd rather not)
    nilcheck(arg[4],"CC-OSish")
    nilcheck(arg[5],"master")
    nilcheck(arg[3],"Link-Jon")
    if not fs.getDir(arg[1]) then
        local file = http.get("https://raw.githubusercontent.com/"..arg[3].."/"..arg[4].."/"..arg[5].."/"..arg[2])
        local f2 file.readAll() -- all i need is the data. dont need the other stuff from the get request. or have anything else in the request either.
        Link-Jon-1.0/functions/git.lua
        file.close()
        file.open(filename,"w")
        file.write(f2)
        file.close()
    else
        return(false)
end
