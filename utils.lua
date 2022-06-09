return {
    playSound = function (soundId: number, volume: number)
        local sound = Instance.new('Sound')
        sound.SoundId = 'rbxassetid://' .. soundId or 'nil'
        sound.Volume = volume or 1
        game:GetService("SoundService"):PlayLocalSound(sound)
        local ended
        ended = sound.Ended:Connect(function()
            game:GetService("Debris"):AddItem(sound, 0.01)
            ended:Disconnect()
        end)
    end
}