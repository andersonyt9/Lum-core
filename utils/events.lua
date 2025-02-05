RegisterServerEvent('lum-core:getPlayer', function()
    local playerId = source
    local identifier = Framework.getPlayerIdentifier(playerId) -- Chama o adaptador correto
end)

RegisterNetEvent('lum-core:notify', function(message)
    local playerId = source
    Framework.notify(playerId, message)
    LogWebhook('notify', ('Jogador %s recebeu notificação: %s'):format(playerId, message))
end)