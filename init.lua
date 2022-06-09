-- Preload content

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local playerlist = game:HttpGet(rawRoot .. 'ui/playerlist.lua')

local utils = loadstring(game:HttpGet(rawRoot .. 'utils.lua'))()

-- Load content

loadstring(playerlist, 'playerlist')(utils)