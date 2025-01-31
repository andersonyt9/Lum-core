local Levels = {}

-- Tabela para armazenar os níveis e experiência dos jogadores
local playersLevels = {}

-- Função para adicionar experiência a um jogador
function Levels.AddExperience(playerId, amount)
    if not playersLevels[playerId] then
        playersLevels[playerId] = { level = 1, experience = 0 }
    end

    playersLevels[playerId].experience = playersLevels[playerId].experience + amount

    -- Verifica se o jogador subiu de nível
    while playersLevels[playerId].experience >= Levels.GetExperienceForNextLevel(playersLevels[playerId].level) do
        playersLevels[playerId].experience = playersLevels[playerId].experience - Levels.GetExperienceForNextLevel(playersLevels[playerId].level)
        playersLevels[playerId].level = playersLevels[playerId].level + 1
        Notifications.Send(playerId, string.format('Você subiu para o nível %d!', playersLevels[playerId].level), 'success')
    end

    Logs.Write('INFO', string.format('Jogador %d ganhou %d de experiência.', playerId, amount))
end

-- Função para obter a experiência necessária para o próximo nível
function Levels.GetExperienceForNextLevel(currentLevel)
    return currentLevel * 1000 -- Exemplo: 1000 de experiência por nível
end

-- Função para obter o nível e experiência de um jogador
function Levels.GetPlayerLevel(playerId)
    if playersLevels[playerId] then
        return playersLevels[playerId].level, playersLevels[playerId].experience
    else
        return 1, 0
    end
end

-- Retorna a interface de níveis
return Levels