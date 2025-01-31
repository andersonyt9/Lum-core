local function SendWebhookLog(webhookUrl, logType, playerId, message)
    local playerName = GetPlayerName(playerId)
    local identifier = GetPlayerIdentifier(playerId, 0)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')

    local embed = {
        {
            title = logType,
            description = message,
            fields = {
                { name = 'Jogador', value = playerName, inline = true },
                { name = 'ID', value = playerId, inline = true },
                { name = 'Identifier', value = identifier, inline = true },
                { name = 'Horário', value = timestamp, inline = true }
            },
            color = 0xFF0000
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers)
        if err then
            print("Erro ao enviar log: " .. err)
        end
    end, 'POST', json.encode({ embeds = embed }), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('lum-core:log')
AddEventHandler('lum-core:log', function(logType, message)
    local webhookUrl = GetConvar('lumcore_webhook', '')
    if webhookUrl ~= '' then
        SendWebhookLog(webhookUrl, logType, source, message)
    else
        print("Webhook não configurado para logs.")
    end
end)