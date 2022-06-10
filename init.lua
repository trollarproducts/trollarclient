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

local uiManager = loadstring(game:HttpGetAsync(rawRoot .. 'ui/uimanager.lua'))()

-- Load content

loadstring(playerlist, 'playerlist')({
    utils = utils,
    uiManager = uiManager,
})
loadstring(adminbail, 'adminbail')({
    utils = utils,
    uiManager = uiManager,
})
loadstring(game:HttpGetAsync(rawRoot .. 'sandbox.lua'), 'sandbox')({
    utils = utils,
    uiManager = uiManager,
})