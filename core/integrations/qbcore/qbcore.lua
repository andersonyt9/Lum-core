local Framework = {}
local QBCore = exports['qb-core']:GetCoreObject()

function Framework.getPlayerIdentifier(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
    return player.PlayerData.citizenid
end

function Framework.notify(playerId, message)
    TriggerClientEvent('QBCore:Notify', playerId, message)
end

return Framework