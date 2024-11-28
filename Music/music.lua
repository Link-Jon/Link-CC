require("musicAPI")

args = {...}
filename = string.gsub(args[1]," ","_")
if fs.exists(args[1]..".dfpwm") and not fs.exists(filename..".dfpwm") then
    print(filename)
    fs.copy(args[1]..".dfpwm", filename..".dfpwm")
end
--[[
if not fs.exists(filename)  args[2] == nil or not string.find(filename)then

    args[2] = "Link's old IP"..filename.."/"..filename..".dfpwm"
    elseif not http.checkURL(args[2]) then
    printerr("invalid URL:")
    error(args[2])
end

if not fs.exists("musicData/") then
    fs.makeDir("musicData")
end
--]]

if args[2] == "split" or args[2] == "true" then
    splitMusic(filename)
else
    playMusic(filename,args[2], args[3])
end