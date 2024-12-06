--[[
pastebin get jRnpZkfN
]]
exponent = 0

local colors = {}
for key,value in pairs(colours) do
    colors[value] = key
end
while exponent < 16 do
    local total = 2^exponent
    term.setTextColor(total)
    print("2 ^ "..exponent..": "..total.." || colours api: "..colors[total])
    sleep(0.5)
    exponent=exponent+1
end