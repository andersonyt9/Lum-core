local quests = {
    { id = 1, label = 'Coletar 10 Maçãs', requiredItem = 'apple', requiredAmount = 10, reward = 500 },
    { id = 2, label = 'Entregar 5 Pães', requiredItem = 'bread', requiredAmount = 5, reward = 300 }
}

function CompleteQuest(playerId, questId)
    local quest = quests[questId]
    if not quest then return false, "Tarefa inválida." end

    local itemCount = exports['lum-core']:GetItemCount(playerId, quest.requiredItem)
    if itemCount >= quest.requiredAmount then
        exports['lum-core']:RemoveItem(playerId, quest.requiredItem, quest.requiredAmount)
        exports['lum-core']:AddMoney(playerId, quest.reward)
        return true, string.format('Tarefa completada! Você recebeu $%d.', quest.reward)
    else
        return false, string.format('Você precisa de %d %s para completar esta tarefa.', quest.requiredAmount, quest.requiredItem)
    end
end

-- Exporta a função
exports('CompleteQuest', CompleteQuest)