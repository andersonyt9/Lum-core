RegisterNetEvent('lum-core:showNotification')
AddEventHandler('lum-core:showNotification', function(message)
    exports['lum-core']:ShowNotification(message)
end)