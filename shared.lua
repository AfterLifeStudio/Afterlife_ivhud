
---@return string
local GetFramework = function()
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

---@type string
Framework = GetFramework() -- qb / esx /qbox /ox






Config.settings = {
    -- {
    --     name = 'Preview',
    --     show = true,
    --     value = false,
    --     type = 'button',
    --     catagory = 'general'
    -- },
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
        show = true, -- Set this to false if you are using Config.gps function
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
        value = true, -- True  == KMH and False == MPH
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
