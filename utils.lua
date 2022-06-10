-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local uiManager = loadstring(game:HttpGet(rawRoot .. 'ui/uimanager.lua'))()

local events = ...

-- Script

local getasset = getcustomasset or getsynasset
local alreadyLoaded
if not isfolder('trollarclient') then
    makefolder('trollarclient')
end
if isfile('trollarclient/alreadyDownloadedFiles.json') then
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
    end,
    notif = function (name, desc, time: number)
        local container = uiManager.new('Container')
        local notif = Instance.new('Frame', container)
        notif.Size = UDim2.new(0.3, 0, 0.055, 0)
        notif.Position = UDim2.new(0.5, 0, 0.9, 0)
        notif.AnchorPoint = Vector2.new(0.5, 0.9)
        notif.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
        Instance.new('UICorner', notif)
        local title = Instance.new('TextLabel', notif)
        title.BackgroundTransparency = 1
        title.BorderSizePixel = 0
        title.TextSize = 14
        title.Font = Enum.Font.GothamBlack
        title.TextColor3 = Color3.fromRGB(198, 198, 198)
        title.Position = UDim2.new(0.5, 0, 0.2, 0)
        title.AnchorPoint = Vector2.new(0.5, 0.5)
        title.Text = name
        local Line = Instance.new('Frame', notif)
        Line.BorderSizePixel = 0
        Line.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        Line.Size = UDim2.new(1, 0, 0.025, 0)
        Line.Position = UDim2.new(0.5, 0, 0.4, 0)
        Line.AnchorPoint = Vector2.new(0.5, 0, 0.3, 0)
        local Description = Instance.new('TextLabel', notif)
        Description.BackgroundTransparency = 1
        Description.BorderSizePixel = 0
        Description.TextSize = 14
        Description.Font = Enum.Font.GothamBlack
        Description.TextColor3 = Color3.fromRGB(198, 198, 198)
        Description.Position = UDim2.new(0.5, 0, 0.7, 0)
        Description.AnchorPoint = Vector2.new(0.5, 0.5)
        Description.Text = desc
        game:GetService("Debris"):AddItem(container, time or 3)
    end,
    deletetrollarclient = function()
        events.delete:Fire()
        uiManager.clearCreated()
    end,
    getEvent = function (name)
        return events[name]
    end,
}