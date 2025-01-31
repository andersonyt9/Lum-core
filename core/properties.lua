local Properties = {}

-- Tabela para armazenar as propriedades
local properties = {}

-- Função para criar uma propriedade
function Properties.CreateProperty(propertyId, propertyData)
    properties[propertyId] = propertyData
    Logs.Write('INFO', string.format('Propriedade %d criada.', propertyId))
end

-- Função para comprar uma propriedade
function Properties.BuyProperty(playerId, propertyId)
    local property = properties[propertyId]
    if property and not property.owner then
        if Economy.GetMoney(playerId) >= property.price then
            Economy.RemoveMoney(playerId, property.price)
            property.owner = playerId
            Logs.Write('INFO', string.format('Jogador %d comprou a propriedade %d.', playerId, propertyId))
            Notifications.Send(playerId, string.format('Você comprou a propriedade %s!', property.name), 'success')
        else
            Logs.Write('WARNING', string.format('Jogador %d não tem dinheiro suficiente para comprar a propriedade %d.', playerId, propertyId))
            Notifications.Send(playerId, 'Dinheiro insuficiente para comprar a propriedade.', 'error')
        end
    else
        Logs.Write('ERROR', string.format('Propriedade %d não encontrada ou já possui dono.', propertyId))
    end
end

-- Função para vender uma propriedade
function Properties.SellProperty(playerId, propertyId)
    local property = properties[propertyId]
    if property and property.owner == playerId then
        Economy.AddMoney(playerId, property.price)
        property.owner = nil
        Logs.Write('INFO', string.format('Jogador %d vendeu a propriedade %d.', playerId, propertyId))
        Notifications.Send(playerId, string.format('Você vendeu a propriedade %s!', property.name), 'success')
    else
        Logs.Write('ERROR', string.format('Propriedade %d não encontrada ou não pertence ao jogador %d.', propertyId, playerId))
    end
end

-- Função para obter as propriedades de um jogador
function Properties.GetPlayerProperties(playerId)
    local playerProperties = {}
    for propertyId, property in pairs(properties) do
        if property.owner == playerId then
            table.insert(playerProperties, property)
        end
    end
    return playerProperties
end

-- Retorna a interface de propriedades
return Properties