local Commands = {}
local Config = require 'core.config'

-- Função para exibir a ajuda dos comandos
function Commands.Help(playerId)
    local helpMessage = [[
Comandos de Configuração:
- /config set <chave> <valor>: Define um valor na configuração.
- /config get <chave>: Exibe o valor de uma chave na configuração.
- /config save: Salva as alterações no arquivo de configuração.
- /config reload: Recarrega o arquivo de configuração.
    ]]
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Ajuda', helpMessage } })
end

-- Função para definir um valor na configuração
function Commands.SetConfig(playerId, key, value)
    local keys = {}
    for k in string.gmatch(key, "[^.]+") do
        table.insert(keys, k)
    end

    local current = Config.data
    for i = 1, #keys - 1 do
        if not current[keys[i]] then
            current[keys[i]] = {}
        end
        current = current[keys[i]]
    end

    current[keys[#keys]] = value
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', string.format('Configuração %s definida para %s.', key, value) } })
end

-- Função para obter um valor da configuração
function Commands.GetConfig(playerId, key)
    local keys = {}
    for k in string.gmatch(key, "[^.]+") do
        table.insert(keys, k)
    end

    local current = Config.data
    for i = 1, #keys do
        if not current[keys[i]] then
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', string.format('Chave %s não encontrada.', key) } })
            return
        end
        current = current[keys[i]]
    end

    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Configuração', string.format('%s = %s', key, json.encode(current)) } })
end

-- Função para salvar a configuração
function Commands.SaveConfig(playerId)
    Config.Save()
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', 'Configuração salva com sucesso!' } })
end

-- Função para recarregar a configuração
function Commands.ReloadConfig(playerId)
    Config.Load()
    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', 'Configuração recarregada com sucesso!' } })
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