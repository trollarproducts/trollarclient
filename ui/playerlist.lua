-- Preload modules

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local uiManager = loadstring(game:HttpGet(rawRoot .. 'ui/uimanager.lua'))()

-- Definitions

local players = game:GetService("Players")

-- Script

if game:GetService("CoreGui"):FindFirstChild("PlayerList") then
    game:GetService("CoreGui"):FindFirstChild("PlayerList"):Destroy()
end

local container = uiManager.new('Container')