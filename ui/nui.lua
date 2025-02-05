RegisterNUICallback('setLanguage', function(data, cb)
    local playerId = source
    exports['lum-core']:SetPlayerLanguage(playerId, data.lang)
    cb({ success = true })
end)

-- Comando para abrir a UI de idioma
RegisterCommand('langui', function(source)
    local playerId = source
    TriggerClientEvent('lum-core:openLanguageUI', playerId)
end)