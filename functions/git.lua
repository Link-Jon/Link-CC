function github(branch,name,filename)
    branch==master -- better failsafe for errors pls...
    if not filename then
        local file = http.get("https://github.com/Link-Jon/CC-OSish/"..branch.."somethinggoeshere"..name)
        local f2 file.readAll()
        file.close()
        file.open(filename,"w")
        file.write(f2)
        file.close()
    else
        return(false)
end



  
