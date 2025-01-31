local Missions = {}

-- Tabela para armazenar as missões
local missions = {}

-- Função para adicionar uma missão
function Missions.AddMission(missionId, missionData)
    missions[missionId] = missionData
end

-- Função para iniciar uma missão para um jogador
function Missions.StartMission(playerId, missionId)
    local mission = missions[missionId]
    if mission then
        TriggerClientEvent('Lum-core:StartMission', playerId, mission)
        Logs.Write('INFO', string.format('Jogador %d iniciou a missão %s.', playerId, missionId))
    else
        Logs.Write('ERROR', string.format('Missão %s não encontrada.', missionId))
    end
end

-- Função para completar uma missão
function Missions.CompleteMission(playerId, missionId)
    local mission = missions[missionId]
    if mission then
        -- Dar recompensa ao jogador
        if mission.reward then
            if mission.reward.money then
                Economy.AddMoney(playerId, mission.reward.money)
            end
            if mission.reward.items then
                for item, amount in pairs(mission.reward.items) do
                    Inventory.AddItem(playerId, item, amount)
                end
            end
        end
        Logs.Write('INFO', string.format('Jogador %d completou a missão %s.', playerId, missionId))
        Notifications.Send(playerId, 'Missão completada com sucesso!', 'success')
    else
        Logs.Write('ERROR', string.format('Missão %s não encontrada.', missionId))
    end
end

-- Retorna a interface de missões
return Missions