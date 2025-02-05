local Vehicles = {}

-- Spawnar veículo compatível com qualquer framework
function Vehicles.SpawnVehicle(playerId, model, coords, cb)
    local ped = GetPlayerPed(playerId)
    model = type(model) == 'string' and GetHashKey(model) or model
    
    -- Verificação de modelo
    if not IsModelInCdimage(model) then
        exports['lum-core']:Notify(playerId, 'vehicle_invalid', 'error')
        return
    end
    
    -- Spawn assíncrono para evitar lag
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model) do Citizen.Wait(10) end
        
        local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, coords.heading, true, false)
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        
        -- Registrar no banco de dados (exemplo para propriedade)
        if Config.Vehicles.persist then
            MySQL.insert('INSERT INTO vehicles (owner, model, plate) VALUES (?, ?, ?)', {
                Framework.getPlayerIdentifier(playerId),
                model,
                GetVehicleNumberPlateText(vehicle)
            })
        end
        
        cb(vehicle)
    end)
end

-- Exemplo de uso em comando
RegisterCommand('spawncar', function(source, args)
    local playerId = source
    local model = args[1] or 'adder'
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    
    Vehicles.SpawnVehicle(playerId, model, coords, function(vehicle)
        exports['lum-core']:Notify(playerId, 'vehicle_spawned', 'success', GetLabelText(GetDisplayNameFromVehicleModel(model)))
    end)
end)