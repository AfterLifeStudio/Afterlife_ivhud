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
    seatbelt = false
}


CreateThread(function()
    while true do
        local sleep = 1000

        if vehicle then
            sleep = Config.speedometerspeed
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
                rpm = VehicleState.vehrpm,
                speed = VehicleState.vehspeed,
                fuel = VehicleState.vehfuel,
                engine = VehicleState.damage,
                seatbelt = VehicleState.seatbelt,
                gear = VehicleState.vehgear,
                class = VehicleState.class,
                mileage = 0
            }
            NuiMessage('speedometer', data)
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
                heading = dgr,
                location1 = location1,
                location2 = location2,
            }

            NuiMessage('compass', data)
        end
        Wait(sleep)
    end
end)





CreateThread(function()
    while true do
        local sleep = 1000
        if VehicleState.seatbelt then
            sleep = 0
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        end
        Wait(sleep)
    end
end)



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
    NuiMessage('speedometervisible', state)
    NuiMessage('compassvisible', state)
    VehicleState.class = GetVehicleClass(vehicle)
    VehicleState.seatbelt = false
end)