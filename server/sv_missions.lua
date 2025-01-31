local missions = {
    { id = 1, label = 'Roubar um carro', reward = 1000 },
    { id = 2, label = 'Entregar um pacote', reward = 500 }
}

local playerMissions = {}

function AssignMission(playerId, missionId)
    local mission = nil
    for _, m in ipairs(missions) do
        if m.id == missionId then
            mission = m
            break
        end
    end

    if not mission then return false, "Missão inválida." end

    playerMissions[playerId] = mission
    return true, string.format('Missão atribuída: %s', mission.label)
end

function CompleteMission(playerId)
    local mission = playerMissions[playerId]
    if not mission then return false, "Você não tem uma missão ativa." end

    exports['lum-core']:AddMoney(playerId, mission.reward)
    playerMissions[playerId] = nil
    return true, string.format('Missão completada! Você recebeu $%d.', mission.reward)
end

-- Exporta as funções
exports('AssignMission', AssignMission)
exports('CompleteMission', CompleteMission)