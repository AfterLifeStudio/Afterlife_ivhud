local vehicle

SetFlyThroughWindscreenParams(15.0, 20.0, 17.0, -500.0)

---@class VehicleState
local VehicleState = {
    vehspeed = 0,
    vehrpm = 0,
    vehfuel = 0,
    vehgear = 0,
    damage = 0,
    class = 0,
    mileage = 0,
    seatbelt = false
}

local speedometer = function()
    CreateThread(function()
        while vehicle do
            if GlobalSettings.mphkmh then
                VehicleState.vehspeed = math.ceil(GetEntitySpeed(vehicle) * 2.236936)
            else
                VehicleState.vehspeed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            end
            VehicleState.vehrpm = GetVehicleCurrentRpm(vehicle)
            VehicleState.vehfuel = GetFuel(vehicle)
            VehicleState.vehgear = GetVehicleCurrentGear(vehicle)
            VehicleState.damage = GetVehicleDamage(vehicle)



            local data = {
                show = true,
                rpm = VehicleState.vehrpm,
                speed = VehicleState.vehspeed,
                fuel = VehicleState.vehfuel,
                engine = VehicleState.damage,
                seatbelt = VehicleState.seatbelt,
                gear = VehicleState.vehgear,
                class = VehicleState.class,
                mileagec = Config.mileage, 
                mileage = VehicleState.mileage
            }
            NuiMessage('speedometer', data)
            Wait(Config.speedometerspeed)
        end
    end)
end


CreateThread( function ()
    while true do
        if cache.vehicle then
        local plate = string.gsub(GetVehicleNumberPlateText(cache.vehicle), "^%s*(.-)%s*$", "%1")
        VehicleState.mileage = GetVehicleMileage(plate)
        end
        Wait(2000)
    end
end)

local prevloc1,prevloc2 = '',''

CreateThread(function()
    while true do
        local sleep = 1000
        if vehicle then
            sleep = Config.compassspeed
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local location2 = GetStreetNameFromHashKey(street2)
            local location1 = GetStreetNameFromHashKey(street1)

            if location1 == '' then
                location1 = prevloc1
            else
                prevloc1 = location1
            end

            
            if location2 == '' then
                location2 = prevloc2
            else
                prevloc2 = location2
            end

            local dgr = -(GetGameplayCamRot(0).z - 180)

            local data = {
                heading = dgr,
                location1 = location1,
                location2 = location2,
            }

            NuiMessage('compass', data)
        end
        Wait(sleep)
    end
end)





-- CreateThread(function()
--     while true do
--         local sleep = 1000
--         if VehicleState.seatbelt then
--             sleep = 0
--             DisableControlAction(0, 75, true)
--             DisableControlAction(27, 75, true)
--         end
--         Wait(sleep)
--     end
-- end)



local doesseatbeltexist = function(vehicle)
    local class = GetVehicleClass(vehicle)
    if class ~= 8 and class ~= 13 and class ~= 14 then
        return true
    end
    return false
end

local toggleseatbelt = function()
    if vehicle then
        if doesseatbeltexist(vehicle) then
            VehicleState.seatbelt = not VehicleState.seatbelt
            if VehicleState.seatbelt then
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






lib.onCache('vehicle', function(vehicledata)
    vehicle = vehicledata
    local state = vehicle and true or false
    if state then
        speedometer()
    end
    NuiMessage('speedometervisible', state)
    NuiMessage('compassvisible', state)
    VehicleState.seatbelt = false

    VehicleState.class  = GetVehicleClass(vehicle)
    print(VehicleState.class)
    if VehicleState.class == 8 or VehicleState.class == 13 or VehicleState.class == 14 then
        VehicleState.seatbelt = true
    end

end)
