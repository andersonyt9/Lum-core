RegisterNetEvent('lum-core:startEvent')
AddEventHandler('lum-core:startEvent', function(event)
    -- Exibe uma notificação sobre o evento
    exports['lum-core']:ShowNotification(string.format('Evento iniciado: %s', event.label))

    -- Lógica específica para cada tipo de evento
    if event.type == 'robbery' then
        -- Implemente a lógica para o roubo
    elseif event.type == 'chase' then
        -- Implemente a lógica para a perseguição
    end
end)

RegisterNetEvent('lum-core:endEvent')
AddEventHandler('lum-core:endEvent', function(event)
    -- Exibe uma notificação sobre o término do evento
    exports['lum-core']:ShowNotification(string.format('Evento finalizado: %s', event.label))
end)