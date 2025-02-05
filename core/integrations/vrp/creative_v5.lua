local Framework = {}

function Framework.getPlayerIdentifier(playerId)
    return vRP.getUserId(playerId) -- ID do jogador no vRP
end

function Framework.notify(playerId, message)
    TriggerClientEvent("vrp:showNotify", playerId, message)
end

-- Adicione mais funções conforme necessário
return Framework