-- Preload content

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local playerList = game:HttpGet(rawRoot .. 'ui/playerlist.lua')

-- Load content

loadstring(playerList, 'playerlist')()