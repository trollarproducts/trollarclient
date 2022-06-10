-- Events

local delete = Instance.new('BindableEvent', nil)

-- Preload content

local rawRoot = 'https://raw.githubusercontent.com/trollarproducts/trollarclient/main/'

local playerlist = game:HttpGetAsync(rawRoot .. 'ui/playerlist.lua')

local adminbail = game:HttpGetAsync(rawRoot .. 'adminbail.lua')

local events = {
    delete = delete
}

local utils = loadstring(game:HttpGetAsync(rawRoot .. 'utils.lua'))(events)

-- Load content

loadstring(playerlist, 'playerlist')(utils)
loadstring(adminbail, 'adminbail')(utils)