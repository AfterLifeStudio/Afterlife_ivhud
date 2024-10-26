if not (Config.framework == 'ox') then return end



RegisterNetEvent("ox:playerLoaded", function()
    playerloaded = true
    if globalsettings.skullonfoot or (not Playerhaveitem(Config.gpsitem)) then
        TriggerEvent('Hud:updateSkullstatus', true)
    end
    streamminmap()
    togglehud(true)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Wait(1000)
    if player then
        playerloaded = true
        if globalsettings.skullonfoot or (not Playerhaveitem(Config.gpsitem)) then
            TriggerEvent('Hud:updateSkullstatus', true)
        end
        streamminmap()
        togglehud(true)
    end
end)


AddEventHandler('ox:statusTick', function(values)
    hunger = values.hunger
    thirst = values.thirst
    stress = values.stress
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



Playerhaveitem = function(item)
    local count = exports.ox_inventory:Search('count', item)
    if count > 0 then 
        return true
    end
    return false
end


if (not Config.gps) then return end


AddEventHandler('ox_inventory:itemCount', function(itemName, totalCount)
    if itemName == Config.gpsitem and totalCount > 0 then
        TriggerEvent('Hud:updateSkullstatus', true)
    end
    if itemName == Config.gpsitem and totalCount == 0 then
        TriggerEvent('Hud:updateSkullstatus', false)
    end
end)

