RegisterCommand('givemoney', function(source, args)
    local playerId = source
    local targetId = tonumber(args[1])
    local amount = tonumber(args[2])

    if not targetId or not amount then
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', 'Uso correto: /givemoney [id] [quantidade]' } })
        return
    end

    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        exports['lum-core']:AddMoney(targetId, amount)
    elseif framework == 'qbcore' then
        exports['lum-core']:AddMoney(targetId, amount)
    elseif framework == 'vrp' then
        exports['lum-core']:AddMoney(targetId, amount)
    else
        -- Standalone
        TriggerClientEvent('lum-core:addMoney', targetId, amount)
    end

    TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', string.format('Você deu $%d para o jogador %d', amount, targetId) } })
end, true)