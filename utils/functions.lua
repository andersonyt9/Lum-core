local playerCache = {}

function GetCachedPlayer(playerId)
    if not playerCache[playerId] then
        playerCache[playerId] = {
            identifier = Framework.getPlayerIdentifier(playerId),
            language = GetPlayerLanguage(playerId)
        }
    end
    return playerCache[playerId]
end

-- Limpar cache ao desconectar
AddEventHandler('playerDropped', function()
    playerCache[source] = nil
    LogWebhook('player_disconnect', string.format("Jogador %s desconectou-se.", source))
end)

function CachePlayer(playerId)
    if not playerCache[playerId] then
        playerCache[playerId] = API.GetPlayer(playerId)
    end
    return playerCache[playerId]
end

-- Limpeza automática a cada 10 minutos
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(600000)
        playerCache = {}
    end
end)