function discord()
    mprint("Join the discord that i for some reason made for this file!")
    mprint("https://discord.gg/MYyHVzB")
end

function discogen()
    head = {}
    GenCos="https://discordapp.com/595567348916944915/595567348916944919"
    mprint("Paste link?")
    mwrite("y / n\n>")
        if read()=="y" then
                mwrite("Paste channel link\n>")
                discordlink=read()
                disco=http.get(discordlink,"")
            else
                mwrite("What channel?\n General-CC = CCG \n General-Cosmic = GC")
                input=read()
                if input==CCG then
                    discordlink=GenCos
                end
        end
    disco=http.get(discordlink)
    disco.readAll()

end
