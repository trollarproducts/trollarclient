local getasset = getcustomasset or getsynasset
local alreadyLoaded = {}

return {
    playSound = function (url, volume: number)
        local data = game:HttpGet(url)
        if alreadyLoaded[url] then
            data = getasset(alreadyLoaded[url], true)
        else
            alreadyLoaded[url] = game:GetService("HttpService"):GenerateGUID(false)
            writefile(alreadyLoaded[url], data)
            data = getasset(alreadyLoaded[url], true)
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