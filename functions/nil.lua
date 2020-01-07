
function nilcheck(var, default)
    local nilary = {'nil','Nil','NIL','NULL','null','Null','',' '}
    if var==nilary then
        if not default then
                var=nil
            else
                var=default
        end
    return(var)
end
