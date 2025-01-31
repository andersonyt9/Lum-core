local ESX = nil

if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
end

function GetPlayerFromId(playerId)
    return ESX.GetPlayerFromId(playerId)
end

function AddMoney(playerId, amount)
    local player = GetPlayerFromId(playerId)
    if player then
        player.addMoney(amount)
    end
end

-- Exporta funções
exports('GetPlayerFromId', GetPlayerFromId)
exports('AddMoney', AddMoney)