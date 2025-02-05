local Admin = {}
local Framework = require 'core/integrations/' .. Config.Framework

-- Verifica se o jogador é admin
function Admin.IsAdmin(playerId)
    local player = exports['lum-core']:lumAPI().GetPlayer(playerId)
    return player.group == 'admin' or player.group == 'superadmin'
end

-- Comando para kickar jogador
RegisterCommand('kick', function(source, args)
    local adminId = source
    local targetId = tonumber(args[1])
    local reason = table.concat(args, ' ', 2) or 'Sem motivo'

    if Admin.IsAdmin(adminId) then
        DropPlayer(targetId, 'Você foi kickado. Motivo: ' .. reason)
        exports['lum-core']:LogWebhook('admin_action', string.format(
            "[KICK] Admin: %s | Jogador: %s | Motivo: %s",
            Framework.getPlayerIdentifier(adminId),
            Framework.getPlayerIdentifier(targetId),
            reason
        ))
    end
end, false)