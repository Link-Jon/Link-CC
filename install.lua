function replace(name)
    if fs.exists(name) then
        print("WARNING: \'"..name.."\' detected!")
        fs.copy(name, "user"..name)
        fs.delete(name)
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
        dirtrue = "sys/"
end
        
while not dircheck do
    print("Input a brief version of your username, or the directory that you would like to use. This will contain pretty much all of my files. If it's not empty, then items inside may end up being deleted. This only appears after 'sys' has been checked (this will be the name for a directory)")
    dirtrue = read()
    if not fs.exists(dirtrue) then
            dircheck=true
        else
            dirtrue=false
            print("ERR: File/Folder exists")
    end
end
--im going to let the print command have fun with that. infact ima go see how that works so i can
--make the write command work like it.

if dirtrue then
    fs.makeDir(dirtrue)
    temp=fs.open(dirtrue.."notes","w")
    temp.write("directory="..dirtrue)
    temp.close()
    temp=nil
end

while counter do
    lista = gitlist[counter]
    listb = gotlist[counter]
    
    temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/Link-Jon-1.0/"..lista)
    --temp = http.get("https://raw.githubusercontent.com/Link-Jon/CC-OSish/master/"..lista)
    
    temp.readAll()
    print("Downloaded: "..lista.." as "..listb)
    if lista==exception or dirtrue==nil then
            file = fs.open(lista,"w")
        else
            file = fs.open(dirtrue..lista,"w")
    end
    file.write(temp)
    counter=counter+1
    --bad. im going to let it bios error to end. not a great idea, should be changed.
end

end --ends function

install()