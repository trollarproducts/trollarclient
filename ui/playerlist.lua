-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local uiManager = loadstring(game:HttpGet(rawRoot .. 'ui/uimanager.lua'))()

local util = ...

-- Definitions

local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")

-- Script

if coreGui:FindFirstChild("PlayerList") then
    coreGui:FindFirstChild("PlayerList"):Destroy()
end

local container = uiManager.new('Container')
local topbar = Instance.new('TextLabel', container)
topbar.Size = UDim2.new(0.1, 0, 0.025, 0)
topbar.Position = UDim2.new(0.95, 0, 0.005, 0)
topbar.AnchorPoint = Vector2.new(0.95, 0, 0.005, 0)
topbar.BackgroundColor3 = Color3.fromRGB(8,8,8)
topbar.Text = 'People'
topbar.TextColor3 = Color3.fromRGB(198, 198, 198)
topbar.TextSize = 15
topbar.Font = Enum.Font.GothamBlack
Instance.new('UICorner', topbar)
local listbg = Instance.new("Frame", container)
listbg.Size = UDim2.new(0.1, 0, 0.25, 0)
listbg.Position = UDim2.new(0.95, 0, 0.025, 0)
listbg.AnchorPoint = Vector2.new(0.95, 0, 0.025, 0)
listbg.BackgroundColor3 = Color3.fromRGB(12,12,12)
Instance.new('UICorner', listbg)
local list = Instance.new("ScrollingFrame", container)
list.Size = UDim2.new(0.1, 0, 0.25, 0)
list.Position = UDim2.new(0.95, 0, 0.025, 0)
list.AnchorPoint = Vector2.new(0.95, 0, 0.025, 0)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
Instance.new('UIListLayout', list).Padding = UDim.new(0, 2)
local plrButton = Instance.new("TextButton", list)
plrButton.Size = UDim2.new(0.95, 0, 0.075, 0)
plrButton.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
plrButton.Text = 'Example Player'
plrButton.TextColor3 = Color3.fromRGB(198, 198, 198)
plrButton.TextSize = 15
plrButton.Font = Enum.Font.GothamBlack
plrButton.Visible = false
Instance.new('UICorner', plrButton)
for _, plr in pairs(players:GetPlayers()) do
    util.playSound(rawRoot .. 'src_assets_sfx_tick.mp3', 1)
    local btn = plrButton:Clone()
    btn.Name = plr.Name
    btn.Text = plr.DisplayName
    btn.Visible = true
end
game:GetService("Players").PlayerAdded:Connect(function(plr)
    util.playSound(rawRoot .. 'src_assets_sfx_tick.mp3', 1)
    local btn = plrButton:Clone()
    btn.Name = plr.Name
    btn.Text = plr.DisplayName
    btn.Visible = true
    btn.Parent = list
end)
game:GetService("Players").PlayerRemoving:Connect(function(plr)
    util.playSound(rawRoot .. 'src_assets_sfx_tick.mp3', 1)
    if list:FindFirstChild(plr.Name) then
        list:FindFirstChild(plr.Name):Destroy()
    end
end)