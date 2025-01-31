function ShowNotification(message)
    if GetResourceState('es_extended') == 'started' then
        ESX.ShowNotification(message)
    elseif GetResourceState('qb-core') == 'started' then
        QBCore.Functions.Notify(message)
    elseif GetResourceState('vrp') == 'started' then
        TriggerEvent('vrp:showNotification', message)
    else
        -- Standalone
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(true, true)
    end
end

-- Exporta a função
exports('ShowNotification', ShowNotification)