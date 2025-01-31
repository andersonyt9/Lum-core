local factionMissions = {
    { faction = 'ballas', label = 'Roubar um carro', reward = 1000 },
    { faction = 'vagos', label = 'Entregar um pacote', reward = 500 }
}

local activeMissions = {}

function StartFactionMission(playerId, missionId)
    local mission = nil
    for _, m in ipairs(factionMissions) do
        if m.id == missionId then
            mission = m
            break
        end
    end

    if not mission then return false, "Missão inválida." end

    local gang = exports['lum-core']:GetPlayerGang(playerId)
    if gang.name ~= mission.faction then return false, "Você não pertence a esta facção." end

    activeMissions[playerId] = mission
    return true, string.format('Missão atribuída: %s', mission.label)
end

function CompleteFactionMission(playerId)
    local mission = activeMissions[playerId]
    if not mission then return false, "Você não tem uma missão ativa." end

    exports['lum-core']:AddMoney(playerId, mission.reward)
    activeMissions[playerId] = nil
    return true, string.format('Missão completada! Você recebeu $%d.', mission.reward)
end

-- Exporta as funções
exports('StartFactionMission', StartFactionMission)
exports('CompleteFactionMission', CompleteFactionMission)