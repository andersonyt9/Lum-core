local Webhook = {}

-- Função para enviar logs via webhook
function Webhook.SendLog(webhookUrl, title, description, color)
    local embed = {
        {
            ["title"] = title,
            ["description"] = description,
            ["color"] = color or 16711680, -- Vermelho por padrão
            ["footer"] = {
                ["text"] = os.date('%Y-%m-%d %H:%M:%S')
            }
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({ embeds = embed }), { ['Content-Type'] = 'application/json' })
end

-- Retorna a interface de webhook
return Webhook