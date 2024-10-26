
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


globalsettings = {
    showhud = true,
    cinemticmod = false,
    showspeedometer = true,
    showcompass = true,
    speedounit = true,
    fliphud = true,
    skullonfoot = false,
    showminimap = true,
    dynamicinfo = false,
    speedometerspeed = 10,
    showstreet = true,
}



function opensettingsmenu()
    SetNuiFocus(true,true)
 
    PlaySoundFromEntity(-1, "FocusIn", cache.ped, "HintCamSounds", 0, 0)
    SendNUIMessage({
        type = 'settingsmenu',
        data = Config.settings
    })
end


CreateThread(function()
    while (not playerloaded) do 
        Wait(0)
    end
    Wait(1000)
    local settings = Config.settings


    :: dataexists ::
    if GetResourceKvpString('dataexists') then
        for i = 1, #settings do
            local val = GetResourceKvpString(settings[i].name)
            if val == 'true' then
                Config.settings[i].value = true
            elseif val == 'false' then
                Config.settings[i].value = false
            else
                Config.settings[i].value = tonumber(val)
            end
        end
        applyallsettings(Config.settings)
    else
        SetResourceKvp('dataexists', 'true')
        for i = 1, #settings do
            SetResourceKvp(settings[i].name, tostring(settings[i].value))
        end
        goto dataexists
    end
end)

function applyallsettings(settings)
    for i = 1, #settings do
        if settings[i].name == 'mphkmh' then
            globalsettings.speedounit = settings[i].value
        elseif settings[i].name == 'showminimap' then
            globalsettings.showminimap = settings[i].value
        elseif settings[i].name == 'showhud' then
            globalsettings.showhud = settings[i].value
        elseif settings[i].name == 'cinematicmode' then
            globalsettings.cinemticmod = settings[i].value
        elseif settings[i].name == 'showspeedometer' then
            globalsettings.showspeedometer = settings[i].value
        elseif settings[i].name == 'showcompass' then
            globalsettings.showcompass = settings[i].value 
        elseif settings[i].name == 'showstreet' then
            globalsettings.showstreet = settings[i].value 
        elseif settings[i].name == 'fliphud' then
            globalsettings.fliphud = settings[i].value 
        elseif settings[i].name == 'skullonfoot' then
            if Config.gps then settings[i].value = (not Playerhaveitem(Config.gpsitem)) end
            globalsettings.skullonfoot = settings[i].value 
        elseif settings[i].name == 'dynamicinfo' then
            globalsettings.dynamicinfo = settings[i].value 
        end
    end
    streamminmap()
    SendNUIMessage({
        type = 'applyallsettings',
        data = settings
    })
end
RegisterNUICallback('changesettings', function (data, cb)
    cb{{}}
    for i = 1, #Config.settings do
        if Config.settings[i].name == data.name then
            Config.settings[i].value = data.value

        end
    end
end)


RegisterNUICallback('finalizesettings', function (data, cb)
    cb{{}}
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    local settings = Config.settings
    for i = 1, #settings do
        SetResourceKvp(settings[i].name, tostring(settings[i].value))
    end
    applyallsettings(settings)
end)


RegisterNUICallback('resetsettings', function (data, cb)
    cb{{}}
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    for i = 1, #defaultsettings do
        SetResourceKvp(defaultsettings[i].name, tostring(defaultsettings[i].value))
    end
    applyallsettings(defaultsettings)
end)




RegisterNUICallback('exitsettings', function (data, cb)
    cb{{}}
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
    PlaySoundFromEntity(-1, "FocusOut", cache.ped, "HintCamSounds", 0, 0)
    SetNuiFocus(false,false)
end)


RegisterNUICallback('playclicksound', function (data, cb)
    cb{{}}
    PlaySoundFromEntity(-1, "BACK", cache.ped, "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0)
end)
