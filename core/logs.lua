local Logs = {}
local Webhook = require 'core.webhook'
local Config = require 'core.config'

-- Função para registrar logs
function Logs.Write(logType, message, playerId)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local playerName = GetPlayerName(playerId) or 'Desconhecido'
    local logMessage = string.format('[%s] [%s] [Jogador: %s (%d)] %s', timestamp, logType, playerName, playerId, message)

    -- Salva o log em um arquivo
    local logFile = 'Lum-core.log'
    local file = io.open(logFile, 'a')
    if file then
        file:write(logMessage .. '\n')
        file:close()
    else
        print('Erro ao abrir o arquivo de log.')
    end

    -- Envia o log para o webhook
    Webhook.SendLog(Config.data.webhooks.logs, logType, logMessage, 16711680) -- Vermelho
end

-- Retorna a interface de logs
return Logs