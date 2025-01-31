local Commands = {}

-- Função para registrar um comando
function Commands.Register(command, callback, permission)
    RegisterCommand(command, function(source, args)
        local playerId = source
        if permission and not Permissions.HasPermission(playerId, permission) then
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', 'Você não tem permissão para executar este comando.' } })
            return
        end
        callback(playerId, args)
    end, false)
end

-- Retorna a interface de comandos
return Commands