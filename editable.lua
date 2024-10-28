PlayerLoaded = false
hunger = 100
thirst = 100
stress = 0

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
    if GlobalSettings.fliphud then
        posX = -0.011
        posY = 0.003
    end
    screenx, screeny = GetActiveScreenResolution()
    if screenx == 4096 and screeny == 2160 then
        posX = 0.862
        posY = -0.006
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1080 then
        posX = 0.97
        posY = -0.045
        if GlobalSettings.fliphud then
            posX = -0.157
            posY = -0.045
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1600 then
        posX = 0.7425
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.017
            posY = 0.0105
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2560 and screeny == 1440 then
        posX = 0.835
        posY = 0.003
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.002
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 2048 and screeny == 1536 then
        posX = 0.5919
        posY = 0.0186
        if GlobalSettings.fliphud then
            posX = -0.01
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1680 and screeny == 1050 then
        posX = 0.744
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1440 and screeny == 900 then
        posX = 0.744
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.018
            posY = 0.015
        end
        width = 0.15
        height = 0.24
    end

    if screenx == 1280 and screeny == 1024 then
        posX = 0.55
        posY = 0.016
        if GlobalSettings.fliphud then
            posX = -0.015
            posY = 0.014
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 1024 and screeny == 768 then
        posX = 0.597
        posY = 0.020
        if GlobalSettings.fliphud then
            posX = -0.015
            posY = 0.0186
        end
        width = 0.15
        height = 0.24
    end
    if screenx == 800 and screeny == 600 then
        posX = 0.597
        posY = 0.020
        if GlobalSettings.fliphud then
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
        if not (GlobalSettings.fliphud) then
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






RegisterCommand('resetminimap', function()
    streamminmap()
end)


RegisterCommand('cash', function()
    if GlobalSettings.dynamicinfo then
        SendNUIMessage({
            type = 'showcash'
        })
    end
end)

RegisterCommand('bank', function()
    if GlobalSettings.dynamicinfo then
        SendNUIMessage({
            type = 'showbank'
        })
    end
end)

RegisterCommand('job', function()
    if GlobalSettings.dynamicinfo then
        SendNUIMessage({
            type = 'showjob'
        })
    end
end)





lib.addKeybind({
    name = 'hud-settings',
    description = 'Open Hud Settings',
    defaultKey = Config.settingskey,
    onPressed = function(self)
        opensettingsmenu()
    end,
})


-- local radarloop 


-- hideradarloop = function ()
--     while radarloop do
--         HideHudAndRadarThisFrame()
--         Wait(0)
--     end
-- end



