function AddItem(playerId, item, amount)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.addInventoryItem(item, amount)
        end
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.Functions.AddItem(item, amount)
        end
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        if user then
            vRP.giveInventoryItem({user, item, amount})
        end
    else
        -- Standalone
        TriggerClientEvent('lum-core:addItem', playerId, item, amount)
    end
end

function RemoveItem(playerId, item, amount)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.removeInventoryItem(item, amount)
        end
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.Functions.RemoveItem(item, amount)
        end
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        if user then
            vRP.tryGetInventoryItem({user, item, amount})
        end
    else
        -- Standalone
        TriggerClientEvent('lum-core:removeItem', playerId, item, amount)
    end
end

function GetItemCount(playerId, item)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            return player.getInventoryItem(item).count
        end
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            return player.Functions.GetItemByName(item).amount
        end
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        if user then
            return vRP.getInventoryItemAmount({user, item})
        end
    else
        -- Standalone
        return 0 -- Implemente uma lógica para standalone se necessário
    end
    return 0
end

-- Exporta as funções
exports('AddItem', AddItem)
exports('RemoveItem', RemoveItem)
exports('GetItemCount', GetItemCount)