local playerVehicles = {}

function BuyVehicle(playerId, model, price)
    local playerMoney = exports['lum-core']:GetPlayerMoney(playerId)
    if playerMoney >= price then
        exports['lum-core']:RemoveMoney(playerId, price)
        table.insert(playerVehicles[playerId] or {}, { model = model, plate = GeneratePlate(), stored = true })
        playerVehicles[playerId] = playerVehicles[playerId] or {}
        return true, "Veículo comprado com sucesso!"
    else
        return false, "Dinheiro insuficiente."
    end
end

function GetPlayerVehicles(playerId)
    return playerVehicles[playerId] or {}
end

function SpawnPlayerVehicle(playerId, plate)
    local vehicles = playerVehicles[playerId]
    if not vehicles then return false, "Você não possui veículos." end

    for _, vehicle in ipairs(vehicles) do
        if vehicle.plate == plate then
            TriggerClientEvent('lum-core:spawnVehicle', playerId, vehicle.model, vehicle.plate)
            return true, "Veículo spawnado com sucesso!"
        end
    end

    return false, "Veículo não encontrado."
end

function GeneratePlate()
    local plate = ""
    for i = 1, 8 do
        plate = plate .. string.char(math.random(65, 90))
    end
    return plate
end

-- Exporta as funções
exports('BuyVehicle', BuyVehicle)
exports('GetPlayerVehicles', GetPlayerVehicles)
exports('SpawnPlayerVehicle', SpawnPlayerVehicle)