local Vehicles = {}

-- Tabela para armazenar os veículos
local vehicles = {}

-- Função para comprar um veículo
function Vehicles.BuyVehicle(playerId, vehicleModel)
    local vehiclePrice = Config.VehiclePrices[vehicleModel]
    if vehiclePrice then
        if Economy.GetMoney(playerId) >= vehiclePrice then
            Economy.RemoveMoney(playerId, vehiclePrice)
            local vehicleId = #vehicles + 1
            vehicles[vehicleId] = {
                id = vehicleId,
                owner = playerId,
                model = vehicleModel,
                plate = GeneratePlate(),
                color = { r = 255, g = 255, b = 255 } -- Cor padrão
            }
            Logs.Write('INFO', string.format('Jogador %d comprou o veículo %s.', playerId, vehicleModel))
            Notifications.Send(playerId, string.format('Você comprou o veículo %s!', vehicleModel), 'success')
            return vehicleId
        else
            Logs.Write('WARNING', string.format('Jogador %d não tem dinheiro suficiente para comprar o veículo %s.', playerId, vehicleModel))
            Notifications.Send(playerId, 'Dinheiro insuficiente para comprar o veículo.', 'error')
        end
    else
        Logs.Write('ERROR', string.format('Veículo %s não encontrado na lista de preços.', vehicleModel))
    end
    return nil
end

-- Função para personalizar um veículo
function Vehicles.CustomizeVehicle(vehicleId, color)
    local vehicle = vehicles[vehicleId]
    if vehicle then
        vehicle.color = color
        Logs.Write('INFO', string.format('Veículo %d foi personalizado.', vehicleId))
        Notifications.Send(vehicle.owner, 'Veículo personalizado com sucesso!', 'success')
    else
        Logs.Write('ERROR', string.format('Veículo %d não encontrado.', vehicleId))
    end
end

-- Função para obter os veículos de um jogador
function Vehicles.GetPlayerVehicles(playerId)
    local playerVehicles = {}
    for vehicleId, vehicle in pairs(vehicles) do
        if vehicle.owner == playerId then
            table.insert(playerVehicles, vehicle)
        end
    end
    return playerVehicles
end

-- Função para gerar uma placa aleatória
function GeneratePlate()
    local plate = ''
    for i = 1, 8 do
        plate = plate .. string.char(math.random(65, 90))
    end
    return plate
end

-- Retorna a interface de veículos
return Vehicles