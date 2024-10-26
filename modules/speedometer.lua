vehicle = nil
speedometerloop = 10
SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, -500.0)


local function togglespeedometer(state,hideseatbelt)
    SendNUIMessage({
        type = 'speedometer-toggle',
        show = state,
        hideseatbelt = hideseatbelt
    })
end

local function togglecompass(state)
    SendNUIMessage({
        type = 'compass-toggle',
        show = state
    })
end



lib.onCache('vehicle', function(vehicledata)
    vehicle = vehicledata
        if vehicle then
            if globalsettings.showspeedometer then
                local hideseatbelt = false
                if (not doesseatbeltexist(vehicle)) then
                    hideseatbelt = true
                end
                togglespeedometer(true,hideseatbelt)
            end
            if globalsettings.showcompass then
                togglecompass(true)
            end

            if globalsettings.skullonfoot and (not Config.gps) then
            TriggerEvent('Hud:updateSkullstatus',true)
            end
        else
            if globalsettings.showspeedometer then
                togglespeedometer(false,false)
            end
            if globalsettings.showcompass then
                togglecompass(false)
            end

            if globalsettings.skullonfoot and (not Config.gps) then
            TriggerEvent('Hud:updateSkullstatus',false)
            end

            Seatbeltstate = false
            SendNUIMessage({
                type = 'disableseatbelt',
            })
        end
end)






CreateThread(function()
    while true do
        local sleep = 1000
        if vehicle then
            sleep = Config.speedometerspeed 
            local vehspeed
            if globalsettings.speedounit == 'kmh' then
                vehspeed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            else
                vehspeed = math.ceil(GetEntitySpeed(vehicle) * 2.236936)
            end
            local vehrpm = GetVehicleCurrentRpm(vehicle)
            local vehfuel = GetFuel(vehicle) 
            local vehgear = GetVehicleCurrentGear(vehicle)
         
            local data = {
                show = true,
                rpm = vehrpm,
                speed = vehspeed,
                fuel = vehfuel,
                engine = 0,
                seatbelt = false,
                gear = vehgear,
                mileage = 0
            }
            NuiMessage('speedometer',data)
        else
            local data = {show = false}
            NuiMessage('speedometer',data)
        end
        Wait(sleep)
    end
end)




CreateThread(function()
    while true do
        local sleep = 1000
        if vehicle then
            sleep = 10
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local location2 = GetStreetNameFromHashKey(street2)
            local location1 = GetStreetNameFromHashKey(street1)

            local dgr = -(GetGameplayCamRot(0).z - 180)

            local data = {
                show = true,
                heading = dgr,
                location1 = location1,
                location2 = location2,
            }

            NuiMessage('compass', data)
        else
            local data = { show = false }
            NuiMessage('compass', data)
        end
        Wait(sleep)
    end
end)
