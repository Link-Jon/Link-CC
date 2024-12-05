revKeys = {}
for key,value in pairs(keys) do
    revKeys[value] = key
end

while true do
    local event, key, bool = os.pullEvent("key")
    write(key.." ")
    write(revKeys[key].." ")
    write(bool.."\n")
end