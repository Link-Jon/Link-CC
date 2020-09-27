
--Will install from branch Master when im done with it.
--Each release will ALSO get its own install file.
--Ontop of this, there will be a 'beta' install file also that i will use the most for
--testing the new versions i add.

function install()

-- Download as "install", IE: >pastebin get 7W48dz3c install
-- this way i can move it into the main directory when startup loads.
local gitlist = {
    "startup.lua",
    "functions/http.lua",
    "functions/mtext.lua",
    "functions/help.lua",
    "functions/maths.lua",
    "functions/dolua.lua"
}
local gotlist = {"startup","https","mtext","help","calc","dofun"}
local exception = {"startup.lua"} -- doesnt go into the directory. stays in root.

if not fs.exists("sys") then
    dir = "sys/"
    dircheck = true
end

while not dircheck do
    print("Input a name for the directory that you would like to use. This will contain pretty much all of my files. If it's not empty, then items inside may end up being deleted. This only appears after 'sys' has been checked (this will be the name for a directory)")
    dir = read()
    if not fs.exists(dir) then
            dircheck=true
    else
            dircheck=false
            write("WARNING: File/Folder exists. Continue? (y/n)")
            local input = read()
            if input=='y' then
                dircheck=true
            else
               dir=nil
            end
    end
--Tell user that it will loop, if it is going to.
    if dircheck==false then
        print("Warning, this will loop until a usable directory has been found")
    end
end

if dir then

    local str=string.sub(dir,-2,-1)
    if str ~= '/' or str ~= '\\' then
        dir=dir.."/"
    elseif str == '\\' then
        dir=string.sub(dir,1,-2)
        dir=dir.."/"
    end

    fs.makeDir(dir)
    temp=fs.open(".system/notes","w")
    temp.write("dir = ".."'"..dir.."'") -- this hurts my soul
    temp.close() --but its the easiest way to turn it into a string to be read later
    temp=nil
end

for i=1,table.getn(gitlist) do
    lista = gitlist[i]
    listb = gotlist[i]
    if lista==nil then
        return
    end

    temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/Link-Jon-1.0/"..lista)
    --temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/master/"..lista)
    
    raw=temp.readAll()
    if lista==exception[i] or dir==nil then
            file = fs.open(listb,"w")
        else
            file = fs.open(dir.."/"..listb,"w")
    end
    file.write(raw)
    file.close()
    print("Downloaded: "..lista.." as "..listb)
end
print("Finished!")
end --ends function

install()