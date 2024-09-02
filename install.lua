
--Will install from branch Master when im done with it.
--Each release will ALSO get its own install file.
--Correction; while each release will get its own install file, will use this main file for master and...
--generall ALL the branches. most notably with the latest branch and master branch.
--testing the new versions i add.

-- Download as "install", IE: >pastebin get 7W48dz3c install
-- this way i can move it into the main directory when startup loads.
-- (Although it seems to work fine just as a run, like> pastebin run 7W48dz3c)



args = {...}
if args[1] == "v" then
    verbose = true
end

function printVerbose(str)
    if verbose == true then
        print(str)
    end
end
--if verbose, print string.

-- I will now need to make a install specifically for minecraft 1.7.10, should i want to keep it
-- functional...


local gitlist = {
    "startup.lua",
    "functions/wireless.lua",
    "functions/logic.lua",
    "functions/help.lua",
    "functions/dolua.lua"
}

local gotlist = {"startup","https","mtext","help","dofun"}
local exception = {"startup.lua"} -- doesnt go into the directory. stays in root.
local commitList = {
    "master/", --main release channel
    "beta-0.7/" --Classic CC release channel
}

--For now i wont change the above functionally. But im 99% sure it can be done with one array.
--Todo... Not important atm cause it actually works.

if not fs.exists("sys") then
    dir = "sys/"
    dircheck = true
end

while not dircheck do
    --If something went wrong with getting the directory automatically...
    write("Input a name for the directory that you would like to use. \nThis will contain pretty much all of the files. If it's not empty, then items inside may end up being deleted. \nThis only appears after 'sys' has been checked (this will be the name for a directory)\n>")
    dir = read()
    if not fs.exists(dir) then
        dircheck=true
        break
    else
        dircheck=false
        write("\nWARNING: File/Folder exists. Continue? (y/n)\n>")
        local input = read()
        if input=='y' then
            dircheck=true
            write("\n")
            break
        else
            dir=nil
        end
    end
--Warn the user that it will loop
    write("\nWarning, this will loop until a usable directory has been found\n")
end

if dir then

    local str=string.sub(dir,-2,-1)
    if str ~= '/' or str ~= '\\' then
        dir=dir.."/"
    elseif str == '\\' then
        dir=string.sub(dir,1,-2)
        dir=dir.."/"
    end 
    --Fixes problems with werid slashes.
    --Honestly, i dont really remember why this was needed.
    --I do remember it being added because of a really specific bug though.

    fs.makeDir(dir)
    local temp=fs.open(".system/notes","w")
    temp.write("dir = ".."'"..dir.."'\n") -- this hurts my soul
    temp.close() --but its the easiest way to turn it into a string to be read later
    temp=nil
    --This should prevent the need of repeating this 'fix' again anywhere else.
end

--write("Would you like to download the latest release or latest commit? (Commit may not launch.)\n('C' for commit, 'M' for release (or 'S' to specify)\n>")
--local commit = read()
--commit=string.lower(commit)

--[[Will leave this but currently unneeded i think.
if commit == "m" or commit == "master" or commit=="main" then
    print("\nDownloading master branch. (Stable release)\n")
    branch = commitList[1]
elseif commit == "c" or commit == "commit" or commit == "beta" then
    print("\nDownloading latest commit; "..commitList[2].."\n")
    branch = commitList[2]
end--]]

branch = "master/"

for i=1,table.getn(gitlist) do
    lista = gitlist[i] --github filenames
    listb = gotlist[i] --CC filenames
    if lista==nil then
        return --?
    end


    local temp, a = http.get("https://raw.githubusercontent.com/Link-Jon/Link-CC/"..branch..lista)
    
    printVerbose(temp,a)
    
    raw=temp.readAll()
    if lista==exception[i] or dir==nil then
        file = fs.open(listb,"w")
    else
        file = fs.open(dir..listb,"w")
    end
    file.write(raw)
    file.close()
    print("Downloaded: "..lista.." as "..listb)
end
print("Finished!")
sleep(0.2)
--[[
write("Would you like to set up a username and password now? (y/n)\n>")
local temp = string.lower(read())
if temp == "y" or temp=="yes" then
    write("\nEnter a username (It will be the admin username FYI)\n>")
    local name=read()
    write("\nEnter a password.\n>")
    local pass=read()

    temp=fs.open(".system/notes","a")
    temp.write("user1={\""..name.."\",\""..pass.."\",2}\n") --name,pass,teir
    temp.flush()

    write("\nDo you want to add another user?\n>")
    name=string.lower(read())
    if name == "t" or name == "true" or name == "yes" or name == "y" then
        looper=true
    else
        looper=false
    end

    while looper==true do
        write("\nEnter the username\n>")
        name=read()
        write("\nEnter the password\n>")
        pass=read()
        write("\nEnter the teir\n(0 for guest, 1 for friend, 2 for admin. See readme for more detail.)\n>")
        teir=read()
        if teir==3 then
            teir=2
        end

        temp.write("user1={\""..name.."\",\""..pass.."\","..teir.."}\n")
        temp.flush()
        write("\n>Do you want to add another user? (y/n)\n>")
        name=string.lower(read())
        if name == "f" or name == "false" or name == "no" or name == "n" then
            looper=false
        else
            looper=true
        end
    end
    temp.close()
    temp=nil
else
    write("\nUnderstood; name/password will be default.")
    write("\nYou will be asked again whenever the program starts.\n")
end --]]
