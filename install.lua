function replace(name)
    if fs.exists(name) then
        print("WARNING: \'"..name.."\' detected!")
        print("Please restart the install file with a file/folder name that isnt used!")
    end
end
 
function install(bug)
 
-- Download as "install", IE: >pastebin get 7W48dz3c install
-- this way i can move it into the main directory when startup loads.
local gitlist = {"startup.lua","functions/http.lua"}
local gotlist = {"startup","https"}
local exception = {"startup.lua"} -- doesnt go into the directory. stays in root.
local counter=1

if not fs.exists("sys") then
        dir = "sys"
        dircheck = true
end
        
while not dircheck do
    print("Input a brief version of your username, or the directory that you would like to use. This will contain pretty much all of my files. If it's not empty, then items inside may end up being deleted. This only appears after 'sys' has been checked (this will be the name for a directory)")
    dir = read()
    if not fs.exists(dir) then
            dircheck=true
        else
            dircheck=false
            print("ERR: File/Folder exists")
    end
end
--im going to let the print command have fun with that. infact ima go see how that works so i can
--make the write command work like it.

if dir then
    fs.makeDir(dir)
    temp=fs.open(dir.."/notes","w")
    temp.write("dir="..dir)
    temp.close()
    temp=nil
end

while counter do
    lista = gitlist[counter]
    listb = gotlist[counter]
    
    temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/Link-Jon-1.0/"..lista)
    --temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/master/"..lista)
    
    temp.readAll()
    if lista==exception[counter] or dir==nil then
            file = fs.open(listb,"w")
        else
            file = fs.open(dir.."/"..listb,"w")
    end
    file.write(temp)
    file.close()
    print("Downloaded: "..lista.." as "..listb)
    counter=counter+1
    --bad. im going to let it bios error to end. not a great idea, should be changed.
end

end --ends function

install()