local API = {}

-- Retorna dados básicos do jogador (compatível com qualquer framework)
function API.GetPlayer(playerId)
    local identifier = Framework.getPlayerIdentifier(playerId)
    local playerData = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', { identifier })
    return {
        source = playerId,
        identifier = identifier,
        group = playerData.group or 'user',
        language = GetPlayerLanguage(playerId)
    }
end

-- Envia notificação universal
function API.Notify(playerId, message, type)
    local lang = GetPlayerLanguage(playerId)
    local translatedMsg = Locales[lang][message] or message
    Framework.notify(playerId, translatedMsg)
    LogWebhook('notification', string.format("Notificação enviada para %s: %s", identifier, translatedMsg))
end

-- Exporte a API para outros scripts
exports('lumAPI', function()
    return API
end)