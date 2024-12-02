exponent = 0
while exponent < 16 do
    term.setTextColor(2^exponent)
    print("2 ^ "..exponent..": "..2^exponent)
    sleep(0.5)
    exponent=exponent+1
end