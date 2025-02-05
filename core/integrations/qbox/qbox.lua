local Framework = {}
local QBCore = exports['qbx-core']:GetCoreObject() -- Ajuste conforme a documentação do QBox

function Framework.getPlayerIdentifier(playerId)
    local player = QBCore.Functions.GetPlayer(playerId)
    return player.PlayerData.citizenid
end

function Framework.notify(playerId, message)
    TriggerClientEvent('qbx:Notify', playerId, message) -- Evento específico do QBox
end

return Framework