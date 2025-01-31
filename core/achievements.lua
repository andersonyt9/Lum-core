local Achievements = {}

-- Tabela para armazenar as conquistas
local achievements = {
    { id = 1, name = 'Primeiros Passos', description = 'Complete sua primeira missão.', reward = { money = 1000 } },
    { id = 2, name = 'Colecionador', description = 'Colete 10 itens.', reward = { items = { { item = 'bread', amount = 5 } } } },
    -- Adicione mais conquistas conforme necessário
}

-- Tabela para armazenar as conquistas desbloqueadas pelos jogadores
local playerAchievements = {}

-- Função para desbloquear uma conquista para um jogador
function Achievements.UnlockAchievement(playerId, achievementId)
    if not playerAchievements[playerId] then
        playerAchievements[playerId] = {}
    end

    if not playerAchievements[playerId][achievementId] then
        playerAchievements[playerId][achievementId] = true
        local achievement = achievements[achievementId]
        if achievement.reward then
            if achievement.reward.money then
                Economy.AddMoney(playerId, achievement.reward.money)
            end
            if achievement.reward.items then
                for _, itemData in ipairs(achievement.reward.items) do
                    Inventory.AddItem(playerId, itemData.item, itemData.amount)
                end
            end
        end
        Logs.Write('INFO', string.format('Jogador %d desbloqueou a conquista %s.', playerId, achievement.name))
        Notifications.Send(playerId, string.format('Conquista desbloqueada: %s', achievement.name), 'success')
    else
        Logs.Write('WARNING', string.format('Jogador %d já desbloqueou a conquista %s.', playerId, achievement.name))
    end
end

-- Função para obter as conquistas desbloqueadas por um jogador
function Achievements.GetPlayerAchievements(playerId)
    return playerAchievements[playerId] or {}
end

-- Retorna a interface de conquistas
return Achievements