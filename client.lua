local voice, voicemode

posX = nil
posY = nil

width = 0.15
height = 0.14



zonex = 0.065
zoney = 0.16

zonexpos = 0.16
zoneypos = 0



---@param state boolean;
DisplayHud = function(state)
    NuiMessage('visible', state)
    DisplayRadar(state)
end

CreateThread(function()
    while true do
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
            stress = stress,
            voice = voice,
            voicemode = voicemode,
        }
        NuiMessage('status', data)
        Wait(1200)
    end
end)

CreateThread(function()
    while true do
        voice = NetworkIsPlayerTalking(cache.playerId)
        Wait(200)
    end
end)


AddEventHandler('pma-voice:setTalkingMode', function(mode)
    voicemode = mode
end)
