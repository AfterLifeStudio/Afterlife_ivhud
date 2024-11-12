

local radarloop

---@class defaultsettings 
local defaultsettings = {}

for _,data in pairs(Config.settings) do
    defaultsettings[data.name] = data.value
end



---@class GlobalSettings 
GlobalSettings = {}






---@return boolean
LoadHud = function ()
    ::Repeat::

    local data = GetResourceKvpString('IVHud:Data')

    if data then
        local data = json.decode(data)
        for k,v in pairs(data) do
            GlobalSettings[k] = v
            Config.settings[k].value = v
        end
    else
        SetResourceKvp('IVHud:Data', json.encode(defaultsettings))
        goto Repeat
    end

    NuiMessage('settings',{visible = false,settings = GlobalSettings,configsettings = Config.settings})

    local response = StreamMinimap()
    return response
end

RegisterCommand('removehudcache', function ()
    DeleteResourceKvp('IVHud:Data')
end)



RegisterNUICallback('exitsettings', function (data, cb)
    for i = 1,#Config.settings do

        Config.settings[i].value = GlobalSettings[Config.settings[i].name]
    end

    NuiMessage('visible', true)
    radarloop = false
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    cb{{}}
end)


RegisterNUICallback('clicksound', function (data, cb)
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    cb{{}}
end)



RegisterNUICallback('settings', function (data, cb)
    Config.settings[data.option].value =  data.value
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    NuiMessage('settings',{visible = true,settings = GlobalSettings,configsettings = Config.settings})
    cb{{}}
end)



RegisterNUICallback('settingsconfirm', function (data, cb)
    for _,data in pairs(Config.settings) do
        GlobalSettings[data.name] = data.value
    end

    SetResourceKvp('IVHud:Data', json.encode(GlobalSettings))

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    radarloop = false
    StreamMinimap()
    DisplayHud(GlobalSettings.showhud)

    NuiMessage('settings',{visible = false,settings = GlobalSettings,configsettings = Config.settings})

    cb{{}}
end)



RegisterNUICallback('settingsreset', function (data, cb)

    for i = 1,#defaultsettings do
        GlobalSettings[defaultsettings[i].name] = defaultsettings[i].value
        Config.settings[i].value = defaultsettings[i].value
    end

    SetResourceKvp('IVHud:Data', json.encode(defaultsettings))
    radarloop = false
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    NuiMessage('settings',{visible = false,settings = GlobalSettings,configsettings = Config.settings})

    cb{{}}
end)


CreateThread(function()
    while true do
        local sleep = 500
        if radarloop or GlobalSettings.cinematicmode then
            sleep = 0
            HideHudAndRadarThisFrame()
        end
        Wait(sleep)
    end
end)


Opensettingsmenu = function()
    radarloop = true
    SetNuiFocus(true,true)
    NuiMessage('visible', false)
    PlaySoundFromEntity(-1, "FocusIn", cache.ped, "HintCamSounds", 0, 0)
    NuiMessage('settings',{visible = true,settings = GlobalSettings,configsettings = Config.settings})
end



lib.addKeybind({
    name = 'hud-settings',
    description = 'Open Hud Settings',
    defaultKey = Config.settingskey,
    onPressed = Opensettingsmenu
})

