--bit depth = loudness
--For any case im downloading from my server,


function downloadMusic(filename, userIP, direct)

    if http.checkURL(userIP) then
        settings.set("musicIP", userIP)
        settings.save()
    elseif settings.get("musicIP") then 
        print("Invald URL, using previous safe IP")
        userIP
    end

    if not direct then
        

    iter = 0
    max = 50

    while iter < max do
        res, failmsg, partres = http.get(ip..filename.."/"..filename..iter)

        print("Curr Iter: "..iter)

        if res == nil and partres == nil then
            print(failmsg)
            return false
        elseif partres then
            --res = partres
            print("Only partial http.get recieved?")
            print(res)
            print(failmsg)
            print(partres)
        end

        if iter == 0 then
            max = tonumber(res.readLine())
        end
        
        if fs.getFreeSpace(filename) < 128*1028 then
            print("Hey Link, make this dumb thing")
            error("out of space, next disk")
        end
        fileHandle = fs.open(filename.."dfpwm", "a")
        fileHandle.write(res.readAll())
        fileHandle.close()
        
        iter = iter + 1
    end

    return true
end

function splitMusic(filename)

    --copy source file into host folder!!!
    if string.find(filename,".dfpwm") then
        local a b = string.find(filename,".dfpwm")
        filename = string.sub(filename,a,b)
    end
    iter = 1
    for chunk in io.lines(filename..".dfpwm", 128 * 1024) do
        --for chunk in origin file, make new file with iterator
        fileHandle = fs.open(filename.."/"..filename..iter, "w")
        fileHandle.write(chunk)
        fileHandle.close()
        iter = iter + 1
    end

    fileHandle = fs.open(filename.."/"..filename..0, "w")
    fileHandle.write(iter)
    fileHandle.close()
    fs.copy(filename,filename.."/"..filename.."dfpwm")

    return true
end

function playMusic(filename, httpURL)
    print(filename)
    if not httpURL then
        httpURL = filename
    end
    filename = string.gsub(filename,".dfpwm","")
    
    local expect = require("cc.expect")
    local dfpwm = require("cc.audio.dfpwm")
    local speaker = peripheral.find("speaker")

    if fs.exists(filename.."dfpwm") then
        print("Trying to play local "..filename)
        openFile = fs.open(filename..".dfpwm","r")
        if not openFile then
            print("Failed local play: ")
            print(filename..".dfpwm"..": "..tostring(fs.exists(filename..".dfpwm")))
            error(openFile)
        end
    else
        string.gsub(httpURL,"HTTPS://", "HTTP://")
        if type(httpURL) == "string" and http.checkURL(httpURL) then
            print("Trying to play remote "..httpURL)
            openFile, err = http.get(httpURL)
            if not openFile then
                print("Failed remote play: ")
                print(openFile)
                error(err)
            end
        end
    end
            iter = 0
    local decoder = dfpwm.make_decoder()
    

    while openFile do
        iter = iter + 1
        chunk = openFile.read(16*1024)
        buffer = decoder(chunk)
        
        print(iter)
        while not speaker.playAudio(buffer) do
            os.pullEvent("speaker_audio_empty")
        end
    end
end

--require("musicAPI"); playMusic("Heavy_Weight")
return {music = {
    playMusic = playMusic,
    downloadMusic = downloadMusic,
    splitMusic = splitMusic
}}
