local Notifications = {}

-- Função para enviar uma notificação para um jogador
function Notifications.Send(playerId, message, type)
    if type == 'success' then
        TriggerClientEvent('Lum-core:Notify', playerId, message, 'success')
    elseif type == 'error' then
        TriggerClientEvent('Lum-core:Notify', playerId, message, 'error')
    else
        TriggerClientEvent('Lum-core:Notify', playerId, message, 'info')
    end
end

-- Retorna a interface de notificações
return Notifications