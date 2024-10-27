Config = {}

--  setr game_enableFlyThroughWindscreen true
--  add this in the server.cfg for the seatbelt to work

Config.seatbelt = 'b'
Config.settingskey = 'i'


GetFuel = function(vehicle)
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

------- Settings Configuration
--------DONT CHANGE ANYTHING IF YOU DONT KNOW WHAT YOU ARE DOING
Config.settings = {
    {
        name = 'showhud',
        label = "Toggle Hud",
        description = "Randoma",
        show = true,
        value = true,
        type = 'button',
        category = 'general'
    },
    {
        name = 'cinematicmode',
        label = 'Cinemtic Mode',
        description = "Random",
        show = true,
        value = false,
        type = 'button',
        category = 'general'
    },
    {
        name = 'fliphud',
        label = 'Flip Hud',
        description = "Random",
        show = true,
        value = false,
        type = 'button',
        category = 'general'
    },
    {
        name = 'showminimap',
        label = 'Toggle Minimap',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'minimap'
    },
    {
        name = 'skullonfoot',
        label = 'Skull on foot',
        description = "Random",
        show = true,
        value = false,
        type = 'button',
        category = 'minimap'
    },
    {
        name = 'minimapsize',
        label = 'Minimap Size',
        description = "Random",
        show = true,
        value = 10,
        type = 'slider',
        category = 'minimap'
    },
    {
        name = 'showspeedometer',
        label = 'Toggle Speedometer',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    {
        name = 'speedometersize',
        label = 'Speedometer Scale',
        description = "Random",
        show = true,
        value = 10,
        type = 'slider',
        category = 'speedometer'
    },
    {
        name = 'mphkmh',
        label = 'Vehicle Speed Unit',
        description = "Random",
        show = true,
        value = true,
        option1 = 'KMH',
        option2 = 'MPH',
        type = 'select',
        category = 'speedometer'
    },
    {
        name = 'compassize',
        label = 'Compass Scale',
        description = "Random",
        show = true,
        value = 10,
        type = 'slider',
        category = 'speedometer'
    },
    {
        name = 'showcompass',
        label = 'Toggle Compass',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    {
        name = 'showstreet',
        label = 'Toggle Street Names',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    {
        name = 'seatbeltalarm',
        label = 'Toggle Seatbelt Alarm',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'speedometer'
    },
    {
        name = 'showinfo',
        label = 'Toggle Info',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'info'
    },
    {
        name = 'dynamicinfo',
        label = 'Dynamic Info',
        description = "Random",
        show = true,
        value = true,
        type = 'button',
        category = 'info'
    }

}






-- Stress Configuration

Config.StressChance = 0.1         -- Default: 10% -- Percentage Stress Chance When Shooting (0-1)
Config.MinimumStress = 50         -- Minimum Stress Level For Screen Shaking
Config.MinimumSpeedUnbuckled = 50 -- Going Over This Speed Will Cause Stress
Config.MinimumSpeed = 100         -- Going Over This Speed Will Cause Stress

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
