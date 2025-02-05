local Bridge = {}

-- Converter eventos de dinheiro entre frameworks
function Bridge.MoneyEventTransformer(eventName, handler)
    RegisterNetEvent(eventName, function(amount)
        local playerId = source
        local convertedEvent = {
            ['esx:addMoney'] = function() 
                local xPlayer = ESX.GetPlayerFromId(playerId)
                xPlayer.addMoney(amount)
            end,
            ['qbcore:addMoney'] = function()
                local player = QBCore.Functions.GetPlayer(playerId)
                player.Functions.AddMoney('cash', amount)
            end
        }
        if convertedEvent[eventName] then convertedEvent[eventName]() end
    end)
end

-- Exemplo: Unificar evento de dar dinheiro
Bridge.MoneyEventTransformer('lum-core:giveMoney', function(amount)
    -- Lógica comum (ex: verificar permissões)
    LogWebhook('money', 'Dinheiro adicionado via bridge')
end)