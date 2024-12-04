--Todo
--This is a nightmare, i dont know if i want to touch it.
--However, i really, REALLY should just to make it MUCH easier to read.


--bit depth = loudness
--For any case im downloading from my server,

function download(filename, userIP, direct)

    if http.checkURL(userIP) and not direct then
        settings.set("music.IP", userIP)
        settings.save()
    elseif settings.get("music.IP") and not direct then 
        print("Invald URL, using previous safe IP")
        userIP = settings.get("music.IP")
    end

        iter = 0
        max = 50

        while iter < max do

            if direct and filename and not userIP or direct and filename == userIP then
                fullIP = filename
            elseif direct and userIP and not filename then
                fullIP = userIP
            elseif direct then
                error("Not sure which one to use")
            else
                fullIP = userIP..filename.."/"..filename..iter
            end

            res, failmsg, partres = http.get(fullIP)

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

function split(filename)

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

function play(filename, httpURL, printout)

    if not httpURL and settings.get("music.IP") then
        httpURL = settings.get("music.IP")
        print("reset http")
    elseif not httpURL then
        direct = true
        httpURL = filename
    end
    
    local dfpwm = require("cc.audio.dfpwm")
    local speaker = peripheral.find("speaker")

    if fs.exists(filename..".dfpwm") then
        filename = filename..".dfpwm"
    end

    if fs.exists(filename) then
        print("Trying to play local "..filename)
        openFile = fs.open(filename,"r")
        if not openFile then
            print("Failed local play: ")
            print(filename..": "..tostring(fs.exists(filename)))
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
    term.clear()
    if parallel then
        --[[
        function printData(iter, data)
            parallel.waitForAny(
            function()
                while true do
                term.clear()
                term.setCursorPos(1,1)
                print("chunk: "..iter)
                term.setCursorPos(1,2)
                data = textutils.serialise(data)
                data = string.gsub(data," ","")
                print(data)
                sleep(0.25)
                end
            end,

            function()
                while not speaker.playAudio(data) do
                    os.pullEvent("speaker_audio_empty")
                    break
                end
            end
            )
        end]]
    else --if not parallel
        function printData(iter, data)
            print("chunk "..iter)
            while not speaker.playAudio(data) do
                os.pullEvent("speaker_audio_empty")
            end
        end
    end

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

return {
    play = play,
    download = download,
    split = split}
