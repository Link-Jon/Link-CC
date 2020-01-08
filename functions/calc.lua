function calc()
    mwrite("First number:")
    numa=read()
    mprint("What type of calculation")
    mwrite("M / D / A / S\n>")
    fun=read()
    mwrite("Second number:\n>")
    numb=read()
    if fun=="M" or fun=="m" then
            numc=numa*numb
        elseif fun=="D" or fun=="d" then
            numc=numa/numb
        elseif fun=="A" or fun=="a" then
            numc=numa+numb
        elseif fun=="S" or fun=="s" then
            numc=numa-numb
    end
end
