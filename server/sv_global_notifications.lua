function SendGlobalNotification(message)
    TriggerClientEvent('lum-core:showNotification', -1, message)
end

-- Exporta a função
exports('SendGlobalNotification', SendGlobalNotification)