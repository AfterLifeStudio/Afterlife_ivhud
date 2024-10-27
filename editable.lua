PlayerLoaded = false
hunger = 100
thirst = 100
stress = 0
Seatbeltstate = false
currentaspectratio, _aspectratio, screenx, screeny, _screenx, _screeny = 0, 0, 0, 0, 0, 0
aspectratio = 0
-- MINIMAP
CreateThread(function()
    while true do
        if PlayerLoaded then
            SetRadarZoom(1100)
            _screenx, _screeny = GetActiveScreenResolution()
            _aspectratio = GetAspectRatio()
            if (_screenx ~= screenx) or (_screeny ~= screeny) then
                streamminmap()
            end
        end
        Wait(2000)
    end
end)




function Getminimapproperties()
    posX = 0.835
    posY = 0.003
    if globalsettings.fliphud then
        posX = -0.011
        posY = 0.003
    end
    screenx, screeny = GetActiveScreenResolution()
    if screenx == 4096 and screeny == 2160 then
        posX = 0.862
        posY = -0.006
        if globalsettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1080 then
        posX = 0.97
        posY = -0.045
        if globalsettings.fliphud then
            posX = -0.157
            posY = -0.045
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1600 then
        posX = 0.7425
        posY = 0.016
        if globalsettings.fliphud then
            posX = -0.017
            posY = 0.0105
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1440 then
        posX = 0.835
        posY = 0.003
        if globalsettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2048 and screeny == 1536 then
        posX = 0.5919
        posY = 0.0186
        if globalsettings.fliphud then
            posX = -0.01
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1680 and screeny == 1050 then
        posX = 0.744
        posY = 0.016
        if globalsettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1440 and screeny == 900 then
        posX = 0.744
        posY = 0.016
        if globalsettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end

    if screenx == 1280 and screeny == 1024 then
        posX = 0.55
        posY = 0.016
        if globalsettings.fliphud then
            posX = -0.015
            posY = 0.014
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1024 and screeny == 768 then
        posX = 0.597
        posY = 0.020
        if globalsettings.fliphud then
            posX = -0.015
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 800 and screeny == 600 then
        posX = 0.597
        posY = 0.020
        if globalsettings.fliphud then
            posX = -0.015
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end


    -- For Multiple Aspect ratios for 1080p resolution

    if screenx == 1920 and screeny == 1080 then
        currentaspectratio = GetAspectRatio()
        local r = 1.7777777910233 - currentaspectratio
        aspectratio = -(r / 10)
        if not (globalsettings.fliphud) then
            if not (GetIsWidescreen()) then
                aspectratio = aspectratio + -0.02
                posX = posX + 0.02
            end
            if currentaspectratio == 1.5 then
                aspectratio = aspectratio - -0.01
                posX = posX - 0.01
            end
            posX = posX - (r / 2)
        end
    end
end

StreamMinimap = function()
    if Config.maxminimapzone then
        zonex = 0.083
        zoney = 0.19

        zonexpos = 0.11
        zoneypos = 0.06
    end

    local response = Getminimapproperties()
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")


    SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY + -0.01, 0.15, 0.2)
    SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX + zonexpos, posY - zoneypos, zonex, zoney)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', posX - 0.018, posY + 0.063, 0.256 + aspectratio, 0.337)
    SetMinimapClipType(1)

    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)

end





RegisterNetEvent('Hud:updateSkullstatus', function(state)
    SendNUIMessage({
        type = 'dead',
        state = state
    })
end)


-- AddEventHandler('gameEventTriggered', function(event, args)
--     if event == "CEventNetworkEntityDamage" and args[6] == 1 then

--         if not IsEntityAPed(args[1]) or not IsPedAPlayer(args[1]) then
--             return
--         end
--         local victimPed = args[1] -- The victim entity (ped).
--         local victimPlayer = Getcache.serverId(NetworkGetPlayerIndexFromPed(victimPed))

--         if victimPlayer == cache.serverId then
--             TriggerEvent('Hud:updateSkullstatus',false)
--         end
--     end
-- end)

RegisterCommand('resetminimap', function()
    streamminmap()
end)


RegisterCommand('cash', function()
    if globalsettings.dynamicinfo then
        SendNUIMessage({
            type = 'showcash'
        })
    end
end)

RegisterCommand('bank', function()
    if globalsettings.dynamicinfo then
        SendNUIMessage({
            type = 'showbank'
        })
    end
end)

RegisterCommand('job', function()
    if globalsettings.dynamicinfo then
        SendNUIMessage({
            type = 'showjob'
        })
    end
end)


CreateThread(function()
    while true do
        local VehicleDamage = math.ceil(GetEntityHealth(vehicle) / 10)
        SendNUIMessage({
            type = 'enginehealth',
            enginehealth = VehicleDamage
        })
        Wait(1000)
    end
end)




CreateThread(function()
    while true do
        local sleep = 1000
        if Seatbeltstate then
            sleep = 0
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        end
        Wait(sleep)
    end
end)



function doesseatbeltexist(vehicle)
    local class = GetVehicleClass(vehicle)
    if class ~= 8 and class ~= 13 and class ~= 14 then
        return true
    end
    return false
end

local toggleseatbelt = function()
    if cache.vehicle then
        if doesseatbeltexist(cache.vehicle) then
            Seatbeltstate = not Seatbeltstate
            SendNUIMessage({
                type = 'seatbelt',
                state = Seatbeltstate
            })

            if Seatbeltstate then
                SetFlyThroughWindscreenParams(1000.0, 1000.0, 0.0, 0.0)
            else
                SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, -500.0)
            end
        end
    end
end



lib.addKeybind({
    name = 'seatbelt',
    description = 'Toggle vehicle seatbelt',
    defaultKey = Config.seatbelt,
    onPressed = function(self)
        toggleseatbelt()
    end,
})


lib.addKeybind({
    name = 'hud-settings',
    description = 'Open Hud Settings',
    defaultKey = Config.settingskey,
    onPressed = function(self)
        opensettingsmenu()
    end,
})


local radarloop 


hideradarloop = function ()
    while radarloop do
        HideHudAndRadarThisFrame()
        Wait(0)
    end
end

ShowHud = function(state)
    SendNUIMessage({
        type = 'pausemenutogglehud',
        state = not state
    })
    radarloop = not state
    hideradarloop()
end


