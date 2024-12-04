--Todo
--Make this actually look good, YEESH
--its technically functional, but it also cannot download music,
--and.. this...
--this entire thing is just an absolute mess
--downvoted, opposite of eyecandy.


local music = require("musicAPI")

args = {...}
filename = string.gsub(args[1]," ","_")
if fs.exists(args[1]..".dfpwm") and not fs.exists(filename..".dfpwm") then
    print(filename)
    fs.copy(args[1]..".dfpwm", filename..".dfpwm")
end

if not fs.exists(filename) and args[2] == nil then
    args[2] = musicIP..filename.."/"..filename..".dfpwm"
elseif not http.checkURL(args[2]) then
    printerr("invalid URL:")
    error(args[2])
end

if not fs.exists("musicData/") then
    fs.makeDir("musicData")
end
--]]

if args[2] == "split" or args[2] == "true" then
    music.split(filename, nilcheck(args[3]))
else
    music.play(filename, args[2], args[3])
end