local Config = require 'config.webhooks'

-- Função para enviar logs
function LogWebhook(event, message)
    local webhook = Config.Webhooks[event] or Config.Webhooks.default
    local embed = {
        title = "Lum Core Logs",
        description = message,
        color = 0x3498db,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ')
    }
    
    PerformHttpRequest(webhook, nil, 'POST', json.encode({ embeds = { embed } }), { ['Content-Type'] = 'application/json' })
end

-- Exemplo de log de erro
function LogError(errorType, details)
    LogWebhook('error', string.format("**Erro**: %s\n**Detalhes**: ```%s```", errorType, details))
end

-- Exemplo de uso em qualquer função
RegisterServerEvent('lum-core:playerConnected', function()
    LogWebhook('player_connect', 'Jogador conectou-se.')
end)