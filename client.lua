posX = nil
posY = nil

width = 0.15
height = 0.14



zonex = 0.065
zoney = 0.16

zonexpos = 0.16
zoneypos = 0


togglehud = function(state)
    if ((not globalsettings.cinemticmod) and (globalsettings.showhud)) then
        if state then DisplayRadar(true) else DisplayRadar(false) end
        SendNUIMessage({
            type = 'togglehud',
            state = state
        })
    end
end





CreateThread(function()
    SetHudComponentSize(6, 0, 0)
    SetHudComponentSize(7, 0, 0)
    SetHudComponentSize(8, 0, 0)
    SetHudComponentSize(9, 0, 0)
    DisplayRadar(false)
    while true do
        if playerloaded then
            local health = GetEntityHealth(cache.ped)
            local armour = GetPedArmour(cache.ped)
            local oxygen
            if not IsEntityInWater(cache.ped) then
                oxygen = 100 - GetPlayerSprintStaminaRemaining(cache.playerId)
            end
            -- Oxygen
            if IsEntityInWater(cache.ped) then
                oxygen = GetPlayerUnderwaterTimeRemaining(cache.playerId) * 10
            end

            local data = {
                health = health - 100,
                skull = false,
                armour = armour,
                oxygen = oxygen,
                hunger = hunger,
                thirst = thirst,
                stress = stress
            }
            NuiMessage('status', data)
        end
        Wait(1200)
    end
end)


local isTalking

CreateThread(function()
    while true do
        isTalking = NetworkIsPlayerTalking(cache.playerId)
        SendNUIMessage({
            type = 'setVoiceTalk',
            istalking = isTalking
        })
        Wait(200)
    end
end)


AddEventHandler('pma-voice:setTalkingMode', function(mode)
    SendNUIMessage({
        type = 'voice',
        voice = mode
    })
end)




