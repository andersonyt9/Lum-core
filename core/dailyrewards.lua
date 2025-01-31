local DailyRewards = {}

-- Tabela para armazenar as recompensas diárias
local dailyRewards = {
    { day = 1, reward = { money = 1000, items = { { item = 'bread', amount = 2 } } } },
    { day = 2, reward = { money = 2000, items = { { item = 'water', amount = 2 } } } },
    -- Adicione mais dias conforme necessário
}

-- Tabela para armazenar o último dia que o jogador recebeu recompensa
local lastRewardDay = {}

-- Função para dar a recompensa diária a um jogador
function DailyRewards.GiveDailyReward(playerId)
    local currentDay = os.date('%d')
    if lastRewardDay[playerId] ~= currentDay then
        lastRewardDay[playerId] = currentDay

        local reward = dailyRewards[tonumber(currentDay)]
        if reward then
            if reward.money then
                Economy.AddMoney(playerId, reward.money)
            end
            if reward.items then
                for _, itemData in ipairs(reward.items) do
                    Inventory.AddItem(playerId, itemData.item, itemData.amount)
                end
            end
            Logs.Write('INFO', string.format('Jogador %d recebeu a recompensa diária do dia %d.', playerId, currentDay))
            Notifications.Send(playerId, 'Você recebeu sua recompensa diária!', 'success')
        else
            Logs.Write('ERROR', string.format('Recompensa diária para o dia %d não encontrada.', currentDay))
        end
    else
        Logs.Write('WARNING', string.format('Jogador %d já recebeu a recompensa diária hoje.', playerId))
        Notifications.Send(playerId, 'Você já recebeu sua recompensa diária hoje.', 'info')
    end
end

-- Retorna a interface de recompensas diárias
return DailyRewards