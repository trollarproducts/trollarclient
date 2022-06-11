-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local varargs = ...

local uiManager = varargs.uiManager

local util = varargs.utils

-- Definitions

local player = game:GetService("Players").LocalPlayer

local coreGui = game:GetService("CoreGui")

local robloxGui = coreGui:FindFirstChild("RobloxGui") or nil

local events = {}

-- Script

local container = uiManager.new('Container')
local frame = Instance.new('Frame', container)
frame.Size = UDim2.new(0.025, 0, 0.5, 0)
frame.Position = UDim2.new(0, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Instance.new("UICorner", frame)
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
local btns = {
    Exit = {
        Icon = 'rbxassetid://9869123763',
        Callback = function()
            util.deletetrollarclient()
        end
    }
}
for name, data in pairs(btns) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.75, 0, 0.075, 0)
    btn.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
    btn.BorderSizePixel = 0
    btn.Text = ''
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(data.Callback)
    local label = Instance.new('ImageLabel', btn)
    label.Size = UDim2.new(0.75, 0, 0.75, 0)
    label.Position = UDim2.new(0.5, 0, 0.5, 0)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Image = data.Icon
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
end

if robloxGui then
    if robloxGui:FindFirstChild("SettingsShield") then
        if robloxGui:FindFirstChild("SettingsShield"):FindFirstChild("SettingsShield") then
            local shield = robloxGui:FindFirstChild("SettingsShield"):FindFirstChild("SettingsShield")
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
    game:GetService("Debris"):AddItem(container, 0)
end)