-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local varargs = ...

local uiManager = varargs.uiManager

local util = varargs.utils

-- Definitions

local players = game:GetService("Players")
local coreGui = game:GetService("CoreGui")
local robloxGui = coreGui:FindFirstChild("RobloxGui") or nil
local events = {}

-- Script

if coreGui:FindFirstChild("PlayerList") then
    coreGui.PlayerList.Enabled = false
end
if coreGui:FindFirstChild("ThemeProvider") then
    local current = coreGui:FindFirstChild("ThemeProvider")
    if current:FindFirstChild("TopBarFrame") then
        current = current:FindFirstChild("TopBarFrame")
        if current:FindFirstChild("RightFrame") then
            current = current:FindFirstChild("RightFrame")
            if current:FindFirstChild("MoreMenu") then
                current:FindFirstChild("MoreMenu").Visible = false
            end
        end
    end
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
    util.playSound(rawRoot .. 'tick.mp3', 1)
    local btn = plrButton:Clone()
    btn.Name = plr.Name
    btn.Text = plr.DisplayName
    btn.Visible = true
    btn.Parent = list
end
events.playerAdded = game:GetService("Players").PlayerAdded:Connect(function(plr)
    util.playSound(rawRoot .. 'join.mp3', 1)
    local btn = plrButton:Clone()
    btn.Name = plr.Name
    btn.Text = plr.DisplayName
    btn.Visible = true
    btn.Parent = list
end)
events.playerRemoving = game:GetService("Players").PlayerRemoving:Connect(function(plr)
    util.playSound(rawRoot .. 'leave.mp3', 1)
    if list:FindFirstChild(plr.Name) then
        game:GetService("TweenService"):Create(list:FindFirstChild(plr.Name), TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1}):Play()

        game:GetService("Debris"):AddItem(list:FindFirstChild(plr.Name), 0.51)
    end
end)

-- Hide on pause menu opening

if robloxGui then
    if robloxGui:FindFirstChild("SettingsShield") then
        if robloxGui:FindFirstChild("SettingsShield"):FindFirstChild("SettingsShield") then
            local shield = robloxGui:FindFirstChild("SettingsShield"):FindFirstChild("SettingsShield")
            container.Enabled = not shield.Visible
            events.propChanged = shield:GetPropertyChangedSignal('Visible'):Connect(function()
                container.Enabled = not shield.Visible
            end)
            events.deletion = shield.AncestryChanged:Connect(function()
                if not shield:IsDescendantOf(robloxGui) then
                    events.propChanged:Disconnect()
                    events.deletion:Disconnect()
                end
            end)
        end
    end
end

-- Delete on trollarclient removal

events.trollarclientremoved = util.getEvent('delete').Event:Connect(function()
    for _, v in pairs(events) do
        v:Disconnect()
    end
    if coreGui:FindFirstChild("PlayerList") then
        coreGui.PlayerList.Enabled = true
    end
    if coreGui:FindFirstChild("ThemeProvider") then
        local current = coreGui:FindFirstChild("ThemeProvider")
        if current:FindFirstChild("TopBarFrame") then
            current = current:FindFirstChild("TopBarFrame")
            if current:FindFirstChild("RightFrame") then
                current = current:FindFirstChild("RightFrame")
                if current:FindFirstChild("MoreMenu") then
                    current:FindFirstChild("MoreMenu").Visible = true
                end
            end
        end
    end
    game:GetService("Debris"):AddItem(container, 0)
end)