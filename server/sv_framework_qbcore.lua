local QBCore = nil

if GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
end

function GetPlayerFromId(playerId)
    return QBCore.Functions.GetPlayer(playerId)
end

function AddMoney(playerId, amount)
    local player = GetPlayerFromId(playerId)
    if player then
        player.Functions.AddMoney('cash', amount)
    end
end

-- Exporta funções
exports('GetPlayerFromId', GetPlayerFromId)
exports('AddMoney', AddMoney)