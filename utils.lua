local getasset = getcustomasset or getsynasset
local alreadyLoaded
if not isfolder('trollarclient') then
    makefolder('trollarclient')
end
if isfile('trollarclient/settings.json') then
    alreadyLoaded = game:GetService("HttpService"):JSONDecode(readfile('trollarclient/alreadyDownloadedFiles.json'))
else
    alreadyLoaded = {}
end

return {
    playSound = function (url, volume: number)
        local data = game:HttpGet(url)
        if alreadyLoaded[url] then
            data = getasset('trollarclient/'..alreadyLoaded[url], true)
        else
            alreadyLoaded[url] = game:GetService("HttpService"):GenerateGUID(false)
            writefile('trollarclient/alreadyDownloadedFiles.json', game:GetService("HttpService"):JSONEncode(alreadyLoaded))
            writefile('trollarclient/'..alreadyLoaded[url], data)
            data = getasset('trollarclient/'..alreadyLoaded[url], true)
        end
        local sound = Instance.new('Sound')
        sound.SoundId = data
        sound.Volume = volume or 1
        game:GetService("SoundService"):PlayLocalSound(sound)
        local ended
        ended = sound.Ended:Connect(function()
            game:GetService("Debris"):AddItem(sound, 0.01)
            ended:Disconnect()
        end)
    end
}