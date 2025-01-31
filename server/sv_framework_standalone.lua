function GetPlayerFromId(playerId)
    return playerId
end

function AddMoney(playerId, amount)
    -- Implementação básica para standalone
    TriggerClientEvent('lum-core:addMoney', playerId, amount)
end

-- Exporta funções
exports('GetPlayerFromId', GetPlayerFromId)
exports('AddMoney', AddMoney)