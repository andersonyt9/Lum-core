local blockedResources = { 'hacker-tool', 'cheat-menu' } -- Recursos bloqueados

AddEventHandler('onResourceStart', function(resourceName)
    if Config.Security.enableResourceCheck then
        if table.contains(blockedResources, resourceName) then
            LogWebhook('security_alert', 'Recurso bloqueado: ' .. resourceName)
            os.exit() -- Encerra o recurso
        end
    end
end)

-- Verifica se o jogador está usando modificações suspeitas
AddEventHandler('playerConnecting', function()
    local playerId = source
    local numMods = GetNumPlayerMods(playerId)
    if numMods > Config.Security.maxAllowedMods then
        DropPlayer(playerId, 'Modificações não permitidas.')
        LogWebhook('security_alert', 'Jogador ' .. GetPlayerName(playerId) .. ' kickado por mods.')
    end
end)