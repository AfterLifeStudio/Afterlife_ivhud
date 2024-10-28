
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
    NuiMessage('settings',{visible = true,settings = Config.settings})
end




---@return boolean
LoadHud = function ()
    ::Repeat::

    local data = GetResourceKvpString('Hud:Data')
    
    if data then
        local data = json.decode(data)
        for i = 1, #data do
            GlobalSettings[data[i].name] = data[i].value
        end
        Config.settings = data
    else
        SetResourceKvp('Hud:Data', json.encode(Config.settings))
        goto Repeat
    end

    NuiMessage('settings',{visible = false,settings = GlobalSettings})

    local response = StreamMinimap()
    return response
end





RegisterNUICallback('exitsettings', function (data, cb)
    for i = 1,#Config.settings do
        Config.settings[i].value = GlobalSettings[Config.settings[i].name].value
    end

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    cb{{}}
end)

RegisterNUICallback('settings', function (data, cb)

    for i = 1,#Config.settings do
        if Config.settings[i].name == data.option then
            Config.settings[i].value = data.input
            break
        end
    end

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
end)



RegisterNUICallback('settingsconfirm', function (data, cb)
    for i = 1,#Config.settings do
        GlobalSettings[Config.settings[i].name] = Config.settings[i].value
    end

    SetResourceKvp('Hud:Data', json.encode(defaultsettings))

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    NuiMessage('settings',{visible = true,settings = GlobalSettings})
end)



RegisterNUICallback('settingsreset', function (data, cb)

    for i = 1,#defaultsettings do
        GlobalSettings[defaultsettings[i].name] = defaultsettings[i].value
        Config.settings[i].value = defaultsettings[i].value
    end

    SetResourceKvp('Hud:Data', json.encode(defaultsettings))

    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    SetNuiFocus(false,false)
    NuiMessage('settings',{visible = true,settings = GlobalSettings})
end)

