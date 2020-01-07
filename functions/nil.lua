
function nilcheck(var, default)
    local nilary = {'nil','Nil','NIL','NULL','null','Null','',' '}
    if var==nilary then

        var=nil

    end

return(var)

end
