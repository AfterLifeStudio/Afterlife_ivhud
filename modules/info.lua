cash, bank = 0, 0
job = ''
grade = ''



CreateThread(function()
    while true do
            local playerjob = job .. ' - ' .. grade
            NuiMessage('info',{bank = bank,cash = cash,job = playerjob,})
        Wait(1200)
    end
end)
