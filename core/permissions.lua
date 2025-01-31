local Permissions = {}

-- Função para verificar se um jogador tem uma permissão específica
function Permissions.HasPermission(playerId, permission)
    local module = require 'core/framework'
    local frameworkModule = module.init()

    -- Verifica a permissão com base no framework
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        return xPlayer.getGroup() == permission
    elseif Config.Framework == 'vrp' then
        local user_id = vRP.getUserId({playerId})
        return vRP.hasPermission({user_id, permission})
    elseif Config.Framework == 'qbcore' then
        local Player = QBCore.Functions.GetPlayer(playerId)
        return Player.PlayerData.permissions[permission]
    else
        return false
    end
end

-- Retorna a interface de permissões
return Permissions