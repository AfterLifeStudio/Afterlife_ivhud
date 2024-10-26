if not (Config.framework == 'qb') then return end

local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    if globalsettings.skullonfoot or (not Playerhaveitem(Config.gpsitem)) then
        TriggerEvent('Hud:updateSkullstatus', true)
    end
    local playerdata = QBCore.Functions.GetPlayerData()
    previouscash = playerdata.money['cash']
    previousbank = playerdata.money['bank']
    cash = playerdata.money['cash']
    bank = playerdata.money['bank']
    job = playerdata.job.label
    grade = playerdata.job.grade.name
    streamminmap()
    togglehud(true)
    playerloaded = true
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Wait(1000)
    local playerdata = QBCore.Functions.GetPlayerData()
    if playerdata then
        job = playerdata.job.label
        grade = playerdata.job.grade.name
        previouscash = playerdata.money['cash']
        previousbank = playerdata.money['bank']
        cash = playerdata.money['cash']
        bank = playerdata.money['bank']
        if globalsettings.skullonfoot or (not Playerhaveitem(Config.gpsitem)) then
            TriggerEvent('Hud:updateSkullstatus', true)
        end
        streamminmap()
        togglehud(true)
        playerloaded = true
    end
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobs)
    job = jobs.label
    grade = jobs.grade.name
end)



RegisterNetEvent('hud:client:OnMoneyChange', function(type, amount, isMinus)
    local playerdata = QBCore.Functions.GetPlayerData()
    cash = playerdata.money['cash']
    bank = playerdata.money['bank']
end)



RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

local _st = true
CreateThread(function()
    while true do
        local state = IsPauseMenuActive()
        if state == 1 then state = true end
        if not (_st == state) then
            _st = not _st
            SendNUIMessage({
                type = 'pausemenutogglehud',
                state = state
            })
        end
        Wait(1000)
    end
end)


function UpdateStress()
    Notify('Alert','You are getting stressed', 'info')
    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
end

Playerhaveitem = function(item)
    return QBCore.Functions.HasItem(item)
end


if (not Config.gps) then return end

CreateThread(function()
    while true do
        if playerloaded then
            local item = QBCore.Functions.HasItem(Config.gpsitem)
            if item then
                TriggerEvent('Hud:updateSkullstatus', true)
            else
                TriggerEvent('Hud:updateSkullstatus', false)
            end
        end
        Wait(2000)
    end
end)
