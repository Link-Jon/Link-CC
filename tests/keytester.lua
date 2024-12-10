revKeys = {}
for key,value in pairs(keys) do
    revKeys[value] = key
end

while true do
    local event, key, bool = os.pullEvent("key")
    local event, char = os.pullEvent("char")
    if bool then; bool = "true"; else; bool = "false" end
   
    write(key.." ")
    write(revKeys[key].." ")
    write(bool.."\n")
    write("char = "..char.."\n")
    --character detects actual character that should be typed.
    --if it doesnt type anything, then it wont respond.
end