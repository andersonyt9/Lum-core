local Commands = {}
local Config = require 'core.config'

-- Função para definir um valor na configuração
function Commands.SetConfig(playerId, key, value)
    local success, errorMessage = Config.Set(key, value)
    if success then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', string.format('Configuração %s definida para %s.', key, value) } })
    else
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', errorMessage } })
    end
end

-- Registra os comandos
RegisterCommand('config', function(source, args)
    local playerId = source
    local action = args[1]

    if action == 'set' then
        Commands.SetConfig(playerId, args[2], args[3])
    elseif action == 'get' then
        Commands.GetConfig(playerId, args[2])
    elseif action == 'save' then
        Commands.SaveConfig(playerId)
    elseif action == 'reload' then
        Commands.ReloadConfig(playerId)
    else
        Commands.Help(playerId)
    end
end, true)

-- Retorna a interface de comandos
return Commands