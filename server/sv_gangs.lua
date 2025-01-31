local gangs = {
    { name = 'ballas', label = 'Ballas', color = 'purple' },
    { name = 'vagos', label = 'Vagos', color = 'yellow' },
    { name = 'families', label = 'Families', color = 'green' }
}

local playerGangs = {}

function SetPlayerGang(playerId, gangName)
    local gang = nil
    for _, g in ipairs(gangs) do
        if g.name == gangName then
            gang = g
            break
        end
    end

    if not gang then return false, "Facção inválida." end

    playerGangs[playerId] = gang
    return true, string.format('Você entrou na facção %s.', gang.label)
end

function GetPlayerGang(playerId)
    return playerGangs[playerId]
end

function RemovePlayerFromGang(playerId)
    playerGangs[playerId] = nil
    return true, "Você saiu da facção."
end

-- Exporta as funções
exports('SetPlayerGang', SetPlayerGang)
exports('GetPlayerGang', GetPlayerGang)
exports('RemovePlayerFromGang', RemovePlayerFromGang)