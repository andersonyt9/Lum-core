local currentBlips = {}

RegisterNetEvent('lum-core:blips:update')
AddEventHandler('lum-core:blips:update', function(blips)
    -- Remover blips antigos
    for _, blip in pairs(currentBlips) do RemoveBlip(blip) end
    
    -- Adicionar novos
    for name, data in pairs(blips) do
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, data.sprite)
        SetBlipColour(blip, data.color)
        SetBlipScale(blip, data.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(data.label)
        EndTextCommandSetBlipName(blip)
        currentBlips[name] = blip
    end
end)