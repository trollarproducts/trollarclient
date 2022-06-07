local attribute = game:GetService("HttpService"):GenerateGUID(false)

local function new (className)
    if className == 'Container' then
        local screenGui = Instance.new('ScreenGui')
        screenGui.Name = game:GetService('HttpService'):GenerateGUID(false)
        screenGui.DisplayOrder = math.pow(2, 31) - 1
        screenGui.IgnoreGuiInset = true
        screenGui.ResetOnSpawn = false
        screenGui:SetAttribute(attribute, true)
        screenGui.Parent = gethui and gethui() or game:GetService('CoreGui')
    end
end

return {
    new = new
}