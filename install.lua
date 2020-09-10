function replace(name)
    if fs.exists(name) then
        print("WARNING: \'"..name.."\' detected!")
        print("Please restart the install file with a file/folder name that isnt used!")
    end
end
 
function install(bug)
 
-- Download as "install", IE: >pastebin get 7W48dz3c install
-- this way i can move it into the main directory when startup loads.
local gitlist = {
    "startup.lua",
    "functions/http.lua",
    "functions/mtext.lua",
    "functions/help.lua",
    "functions/maths.lua"}
local gotlist = {"startup","https","mtext","help","calc"}
local exception = {"startup.lua"} -- doesnt go into the directory. stays in root.

if not fs.exists("sys") then
        local dir = "sys"
        local dircheck = true
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
            end
        
    end
--Tell user that it will loop, if it is going to.
    if dircheck==false then
        print("Warning, this will loop until a usable directory has been found")
    end
end
--im going to let the print command have fun with that. infact ima go see how that works so i can
--make the write command work like it.

if dir then
    fs.makeDir(dir)
    temp=fs.open("system_notes","w")
    temp.write("dir="..dir)
    temp.close()
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
    --bad. im going to let it bios error to end. not a great idea, should be changed.
    --changed to For loop, fixes this err. (forgot to get rid of x=x+1)
end
print("Finished!")
end --ends function

install()