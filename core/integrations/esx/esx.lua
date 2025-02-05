local Framework = {}
local ESX = nil

TriggerEvent(Config.ESX.getSharedObject, function(obj) ESX = obj end)

function Framework.getPlayerIdentifier(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    return xPlayer.identifier
end

function Framework.notify(playerId, message)
    TriggerClientEvent('esx:showNotification', playerId, message)
end

return Framework