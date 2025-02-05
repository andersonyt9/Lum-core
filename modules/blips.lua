local Blips = {}
local activeBlips = {}

-- Adicionar blip global
function Blips.AddBlip(name, data)
    activeBlips[name] = data
    TriggerClientEvent('lum-core:blips:update', -1, activeBlips)
end

-- Exemplo: Blip de loja
Citizen.CreateThread(function()
    Blips.AddBlip('Loja Central', {
        coords = vector3(25.6, -1345.5, 29.5),
        sprite = 59,
        color = 2,
        scale = 0.8,
        label = 'Loja 24/7'
    })
end)