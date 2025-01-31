local MoneyPlugin = {}

-- Função para inicializar o plugin
function MoneyPlugin.Init()
    RegisterCommand('givemoney', function(source, args)
        local playerId = source
        local targetId = tonumber(args[1])
        local amount = tonumber(args[2])

        if targetId and amount then
            Economy.AddMoney(targetId, amount)
            Logs.Write('INFO', string.format('Jogador %d deu %d de dinheiro ao jogador %d.', playerId, amount, targetId), playerId)
        else
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', 'Uso correto: /givemoney <ID> <Quantidade>' } })
        end
    end, true)
end

-- Retorna o plugin
return MoneyPlugin