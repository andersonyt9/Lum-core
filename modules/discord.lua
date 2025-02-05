local Discord = {}
local HTTP = GetConvar('discord_webhook', 'https://discord.com/api/webhooks/...')

-- Sincroniza grupos do Discord com grupos do servidor
function Discord.SyncRoles(playerId)
    local identifier = Framework.getPlayerIdentifier(playerId)
    local discordId = GetPlayerDiscordId(playerId) -- Função para obter ID do Discord

    PerformHttpRequest(HTTP .. '/roles', function(err, text, headers)
        if text then
            local roles = json.decode(text)
            if roles['admin'] then
                Framework.setPlayerGroup(playerId, 'admin')
            end
        end
    end)
end

-- Evento ao conectar
AddEventHandler('playerConnecting', function()
    Discord.SyncRoles(source)
end)