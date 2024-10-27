
---@class defaultsettings 
local defaultsettings = {}

for i = 1,#Config.settings do
    defaultsettings[i] = {
        name = Config.settings[i].name,
        show = Config.settings[i].show,
        value = Config.settings[i].value,
        type = Config.settings[i].type,
        catagory = Config.settings[i].catagory
    } 
end


---@class GlobalSettings 
GlobalSettings = {}



function opensettingsmenu()
    SetNuiFocus(true,true)
 
    PlaySoundFromEntity(-1, "FocusIn", cache.ped, "HintCamSounds", 0, 0)
    NuiMessage('settings',Config.settings)
end




---@return boolean
LoadHud = function ()
    ::Repeat::

    local data = GetResourceKvpString('Hud:Data')
    
    if data then
        GlobalSettings = json.decode(data)
        Config.settings = json.decode(data)
    else
        SetResourceKvp('Hud:Data', json.encode(Config.settings))
        goto Repeat
    end

    NuiMessage('settings',Config.settings)

    local response = StreamMinimap()
    return response
end





RegisterNUICallback('exitsettings', function (data, cb)
    Config.settings = data
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    cb{{}}
end)

RegisterNUICallback('settingsconfirm', function (data, cb)
    local value = data.input
    GlobalSettings[data.option] = value
    Config.settings[data.option] = value
    SetResourceKvp('Hud:Data', json.encode(Config.settings))

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)

    cb{Config.settings}
end)

RegisterNUICallback('settingsreset', function (data, cb)
    local value = data.input

    for i = 1,#defaultsettings do
        GlobalSettings[i] = {
            name = defaultsettings[i].name,
            show = defaultsettings[i].show,
            value = defaultsettings[i].value,
            type = defaultsettings[i].type,
            catagory = defaultsettings[i].catagory
        } 
    end

    for i = 1,#defaultsettings do
        Config.settings[i] = {
            name = defaultsettings[i].name,
            show = defaultsettings[i].show,
            value = defaultsettings[i].value,
            type = defaultsettings[i].type,
            catagory = defaultsettings[i].catagory
        } 
    end


    SetResourceKvp('Hud:Data', json.encode(defaultsettings))

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)

    cb{defaultsettings}
end)

