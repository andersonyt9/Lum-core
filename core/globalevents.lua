local GlobalEvents = {}

-- Tabela para armazenar os eventos globais
local events = {
    { id = 1, name = 'Evento de Natal', description = 'Participe do evento de Natal e ganhe recompensas especiais!', reward = { money = 5000, items = { { item = 'present', amount = 1 } } } },
    -- Adicione mais eventos conforme necessário
}

-- Tabela para armazenar a participação dos jogadores nos eventos
local playerParticipation = {}

-- Função para participar de um evento global
function GlobalEvents.Participate(playerId, eventId)
    if not playerParticipation[playerId] then
        playerParticipation[playerId] = {}
    end

    if not playerParticipation[playerId][eventId] then
        playerParticipation[playerId][eventId] = true
        local event = events[eventId]
        if event.reward then
            if event.reward.money then
                Economy.AddMoney(playerId, event.reward.money)
            end
            if event.reward.items then
                for _, itemData in ipairs(event.reward.items) do
                    Inventory.AddItem(playerId, itemData.item, itemData.amount)
                end
            end
        end
        Logs.Write('INFO', string.format('Jogador %d participou do evento %s.', playerId, event.name))
        Notifications.Send(playerId, string.format('Você participou do evento %s e ganhou recompensas!', event.name), 'success')
    else
        Logs.Write('WARNING', string.format('Jogador %d já participou do evento %s.', playerId, event.name))
    end
end

-- Função para obter a participação de um jogador nos eventos globais
function GlobalEvents.GetPlayerParticipation(playerId)
    return playerParticipation[playerId] or {}
end

-- Retorna a interface de eventos globais
return GlobalEvents