-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local uiManager = loadstring(game:HttpGet(rawRoot .. 'ui/uimanager.lua'))()

-- Definitions

local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")
local player = players.LocalPlayer

-- Script

if coreGui:FindFirstChild("PlayerList") then
    coreGui:FindFirstChild("PlayerList"):Destroy()
end

local container = uiManager.new('Container')
local frame = Instance.new('Frame', container)
frame.Size = UDim2.new(0.2, 0, 1, 0)
frame.Position = UDim2.new(0.98, 0, 0, 0)
frame.AnchorPoint = Vector2.new(0.99, 0)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
Instance.new('UIListLayout', frame).Padding = UDim.new(0, 5)
local spacer = Instance.new('TextLabel', frame)
spacer.Name = '1Spacer'
spacer.Size = UDim2.new(1, 0, 0.025, 0)
spacer.BorderSizePixel = 0
spacer.BackgroundTransparency = 1
spacer.TextTransparency = 1
local topbar = Instance.new('TextLabel', frame)
topbar.Name = '2Topbar'
topbar.Size = UDim2.new(1, 0, 0.035, 0)
topbar.TextColor3 = Color3.fromRGB(198, 198, 198)
topbar.BackgroundTransparency = 0.1
topbar.Text = "Player List"
topbar.BorderSizePixel = 0
topbar.Font = Enum.Font.GothamBlack
topbar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
topbar.TextSize = 14
Instance.new('UICorner', topbar)
local tempButton = Instance.new('TextLabel', frame)
tempButton.Size = UDim2.new(1, 0, 0.035, 0)
tempButton.TextColor3 = Color3.fromRGB(198, 198, 198)
tempButton.BackgroundTransparency = 0.15
tempButton.Text = "Player List"
tempButton.BorderSizePixel = 0
tempButton.Font = Enum.Font.GothamBlack
tempButton.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
tempButton.TextSize = 12
tempButton.Visible = false
Instance.new('UICorner', tempButton)

for _, plr in pairs(players:GetPlayers()) do
    local clone = tempButton:Clone()
    clone.Name = plr.Name
    clone.Text = plr.Name .. ' (@' .. plr.DisplayName .. ')'
    clone.Visible = true
    clone.Parent = frame
end

players.PlayerAdded:Connect(function(plr)
    local clone = tempButton:Clone()
    clone.Name = plr.Name
    clone.Text = plr.Name .. ' (@' .. plr.DisplayName .. ')'
    clone.Visible = true
    clone.Parent = frame
end)

players.PlayerRemoving:Connect(function(plr)
    if frame:FindFirstChild(plr.Name) then
        frame:FindFirstChild(plr.Name):Destroy()
    end
end)