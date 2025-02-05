local Reports = {}
local activeReports = {}

-- Comando para reportar jogador (/report [ID] [Motivo])
RegisterCommand('report', function(source, args)
    local playerId = source
    local targetId = tonumber(args[1])
    local reason = table.concat(args, ' ', 2) or 'Sem motivo'
    
    activeReports[#activeReports + 1] = {
        reporter = Framework.getPlayerIdentifier(playerId),
        target = Framework.getPlayerIdentifier(targetId),
        reason = reason,
        timestamp = os.time()
    }
    
    -- Notificar administradores
    TriggerClientEvent('lum-core:report:new', -1, activeReports[#activeReports])
    exports['lum-core']:Notify(playerId, 'report_sent', 'success')
end)

-- Interface administrativa para ver reports
RegisterServerEvent('lum-core:report:resolve')
AddEventHandler('lum-core:report:resolve', function(reportIndex)
    if Admin.IsAdmin(source) then
        activeReports[reportIndex] = nil
        LogWebhook('report', 'Reporte resolvido por ' .. GetPlayerName(source))
    end
end)