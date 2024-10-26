Config = {}

--  setr game_enableFlyThroughWindscreen true
--  add this in the server.cfg for the seatbelt to work  

Config.seatbelt = 'b'
Config.settingskey = 'i'


GetFuel = function (vehicle)
    local fuel = math.ceil(GetVehicleFuelLevel(vehicle)) -- change this according to your exports for the fuel system
    return fuel
end

GetFramework = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return 'esx'
    elseif GetResourceState('qbx_core') ~= 'missing' then
        return 'qbx'
    elseif GetResourceState('qb-core') ~= 'missing' then
        return 'qb'
    elseif GetResourceState('ox_core') ~= 'missing' then
        return 'ox'
    end
end

Config.framework = GetFramework() -- qb / esx /qbox /ox


------- Minimap

Config.maxminimapzone = false

------- Speedometer Configuration

-- you can increase them inorder to increase performance
Config.speedometerspeed = 50 -- how many millisecond it will delay before updating the speedometer again
Config.compassspeed = 50     -- how many millisecond it will delay before updating the compass again
Config.compassstring = ' & '

-- the map only appears if player have this item 
Config.gps = false -- if you want to turn on this then disable skull on foot from settings config
Config.gpsitem = 'gps'


------- Settings Configuration
--------DONT CHANGE ANYTHING IF YOU DONT KNOW WHAT YOU ARE DOING
Config.settings = {

    {
        name = 'showhud',
        show = true,
        value = true,
        type = 'button',
        catagory = 'general'

    },
    {
        name = 'cinematicmode',
        show = true,
        value = false,
        type = 'button',
        catagory = 'general'
    },
    {
        name = 'fliphud',
        show = true,
        value = false,
        type = 'button',
        catagory = 'general'
    },
    {
        name = 'showminimap',
        show = true,
        value = true,
        type = 'button',
        catagory = 'minimap'
    },
    {
        name = 'skullonfoot',
        show = true, 
        value = false,
        type = 'button',
        catagory = 'minimap'
    },
    {
        name = 'minimapsize',
        show = true,
        value = 10,
        type = 'slider',
        catagory = 'minimap'
    },
    {
        name = 'showspeedometer',
        show = true,
        value = true,
        type = 'button',
        catagory = 'speedometer'
    },
    {
        name = 'speedometersize',
        show = true,
        value = 10,
        type = 'slider',
        catagory = 'speedometer'
    },
    {
        name = 'mphkmh',
        show = true,
        value = 'mph',
        type = 'button',
        catagory = 'speedometer'
    },
    {
        name = 'compassize',
        show = true,
        value = 10,
        type = 'slider',
        catagory = 'speedometer'
    },
    {
        name = 'showcompass',
        show = true,
        value = true,
        type = 'button',
        catagory = 'speedometer'
    },
    {
        name = 'showstreet',
        show = true,
        value = true,
        type = 'button',
        catagory = 'speedometer'
    },
    {
        name = 'seatbeltalarm',
        show = true,
        value = true,
        type = 'button',
        catagory = 'speedometer'
    },
    {
        name = 'showinfo',
        show = true,
        value = true,
        type = 'button',
        catagory = 'info'
    },
    {
        name = 'dynamicinfo',
        show = true,
        value = true,
        type = 'button',
        catagory = 'info'
    },
}






-- Stress Configuration

Config.StressChance = 0.1          -- Default: 10% -- Percentage Stress Chance When Shooting (0-1)
Config.MinimumStress = 50          -- Minimum Stress Level For Screen Shaking
Config.MinimumSpeedUnbuckled = 50  -- Going Over This Speed Will Cause Stress
Config.MinimumSpeed = 100          -- Going Over This Speed Will Cause Stress

Config.disablestressjobs = {
    police = true,
    ambulance = true,
}

Config.BlacklistVehicle = {
    'jet'
}

Config.WhitelistedWeaponStress = {
    `weapon_petrolcan`,
    `weapon_hazardcan`,
    `weapon_fireextinguisher`
}


Config.BlurIntensity = {
    {
        min = 50,
        max = 60,
        intensity = 1500,
    },
    {
        min = 60,
        max = 70,
        intensity = 2000,
    },
    {
        min = 70,
        max = 80,
        intensity = 2500,
    },
    {
        min = 80,
        max = 90,
        intensity = 2700,
    },
    {
        min = 90,
        max = 100,
        intensity = 3000,
    },
}

Config.EffectInterval = {
    {
        min = 50,
        max = 60,
        timeout = math.random(50000, 60000)
    },
    {
        min = 60,
        max = 70,
        timeout = math.random(40000, 50000)
    },
    {
        min = 70,
        max = 80,
        timeout = math.random(30000, 40000)
    },
    {
        min = 80,
        max = 90,
        timeout = math.random(20000, 30000)
    },
    {
        min = 90,
        max = 100,
        timeout = math.random(15000, 20000)
    }
}
