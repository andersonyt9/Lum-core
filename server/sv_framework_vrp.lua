local vRP = nil

if GetResourceState('vrp') == 'started' then
    vRP = exports['vrp']:getObject()
end

function GetPlayerFromId(playerId)
    return vRP.getUserSource({playerId})
end

function AddMoney(playerId, amount)
    local user = vRP.getUser({playerId})
    if user then
        vRP.giveMoney({user, amount})
    end
end

-- Exporta funções
exports('GetPlayerFromId', GetPlayerFromId)
exports('AddMoney', AddMoney)