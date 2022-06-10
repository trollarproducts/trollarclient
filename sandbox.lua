-- Definitions

local varargs = ...

local util = varargs.utils

local uiManager = varargs.uiManager

local realENV = {
    Instance = Instance,
}

local created = {}

-- Script

getrenv().Instance = {
    new = function(className, defaultParent)
        if string.lower(className) == 'ScreenGui' then
            local container = uiManager.new('Container')
            if defaultParent then
                container.Parent = defaultParent
            end
            created[container:GetDebugId(10)] = container
            return container
        else
            local inst = Instance.new(className)
            if defaultParent then
                inst.Parent = defaultParent
            end
            return inst
        end
    end
}

util.getEvent('delete').Event:connect(function()
    getrenv().Instance = realENV.Instance
    for _, v in pairs(created) do
        v:Destroy()
    end
    created = {}
end)