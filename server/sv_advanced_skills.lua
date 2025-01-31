local playerSkills = {}

local skills = {
    { name = 'strength', label = 'Força', maxLevel = 10 },
    { name = 'stamina', label = 'Resistência', maxLevel = 10 },
    { name = 'accuracy', label = 'Precisão', maxLevel = 10 }
}

function AddSkillXP(playerId, skillName, xp)
    if not playerSkills[playerId] then
        playerSkills[playerId] = {}
    end

    if not playerSkills[playerId][skillName] then
        playerSkills[playerId][skillName] = { xp = 0, level = 1 }
    end

    playerSkills[playerId][skillName].xp = playerSkills[playerId][skillName].xp + xp

    -- Verifica se o jogador subiu de nível
    local requiredXP = playerSkills[playerId][skillName].level * 100
    if playerSkills[playerId][skillName].xp >= requiredXP then
        playerSkills[playerId][skillName].level = playerSkills[playerId][skillName].level + 1
        playerSkills[playerId][skillName].xp = 0
        TriggerClientEvent('lum-core:showNotification', playerId, string.format('Você subiu para o nível %d em %s!', playerSkills[playerId][skillName].level, skillName))
    end
end

function GetPlayerSkill(playerId, skillName)
    if playerSkills[playerId] and playerSkills[playerId][skillName] then
        return playerSkills[playerId][skillName].level, playerSkills[playerId][skillName].xp
    end
    return 0, 0
end

function ApplySkillEffects(playerId)
    local strengthLevel = GetPlayerSkill(playerId, 'strength')
    local staminaLevel = GetPlayerSkill(playerId, 'stamina')
    local accuracyLevel = GetPlayerSkill(playerId, 'accuracy')

    -- Aplica efeitos das habilidades
    SetPlayerMaxHealth(playerId, 100 + (strengthLevel * 10))
    SetPlayerStamina(playerId, 100 + (staminaLevel * 10))
    SetPlayerAccuracy(playerId, 1.0 + (accuracyLevel * 0.1))
end

-- Exporta as funções
exports('AddSkillXP', AddSkillXP)
exports('GetPlayerSkill', GetPlayerSkill)
exports('ApplySkillEffects', ApplySkillEffects)