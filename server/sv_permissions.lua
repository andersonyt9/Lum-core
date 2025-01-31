function IsPlayerAdmin(playerId)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        return player.getGroup() == 'admin'
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        return player.PlayerData.job.name == 'admin'
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        return vRP.hasPermission({user, 'admin'})
    else
        -- Standalone
        return IsPlayerAceAllowed(playerId, 'command')
    end
end

-- Exporta a função
exports('IsPlayerAdmin', IsPlayerAdmin)