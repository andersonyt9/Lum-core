local trades = {}

function StartTrade(player1Id, player2Id)
    trades[player1Id] = { partner = player2Id, items = {}, money = 0 }
    trades[player2Id] = { partner = player1Id, items = {}, money = 0 }
    return true, "Troca iniciada."
end

function AddTradeItem(playerId, item, amount)
    if not trades[playerId] then return false, "Nenhuma troca em andamento." end

    table.insert(trades[playerId].items, { item = item, amount = amount })
    return true, "Item adicionado à troca."
end

function AddTradeMoney(playerId, amount)
    if not trades[playerId] then return false, "Nenhuma troca em andamento." end

    trades[playerId].money = trades[playerId].money + amount
    return true, "Dinheiro adicionado à troca."
end

function AcceptTrade(playerId)
    if not trades[playerId] then return false, "Nenhuma troca em andamento." end

    local partnerId = trades[playerId].partner
    if not trades[partnerId] then return false, "Parceiro de troca não encontrado." end

    -- Troca os itens e o dinheiro
    for _, item in ipairs(trades[playerId].items) do
        exports['lum-core']:RemoveItem(playerId, item.item, item.amount)
        exports['lum-core']:AddItem(partnerId, item.item, item.amount)
    end

    for _, item in ipairs(trades[partnerId].items) do
        exports['lum-core']:RemoveItem(partnerId, item.item, item.amount)
        exports['lum-core']:AddItem(playerId, item.item, item.amount)
    end

    exports['lum-core']:RemoveMoney(playerId, trades[playerId].money)
    exports['lum-core']:AddMoney(partnerId, trades[playerId].money)

    exports['lum-core']:RemoveMoney(partnerId, trades[partnerId].money)
    exports['lum-core']:AddMoney(playerId, trades[partnerId].money)

    trades[playerId] = nil
    trades[partnerId] = nil
    return true, "Troca concluída com sucesso!"
end

function CancelTrade(playerId)
    if not trades[playerId] then return false, "Nenhuma troca em andamento." end

    local partnerId = trades[playerId].partner
    trades[playerId] = nil
    trades[partnerId] = nil
    return true, "Troca cancelada."
end

-- Exporta as funções
exports('StartTrade', StartTrade)
exports('AddTradeItem', AddTradeItem)
exports('AddTradeMoney', AddTradeMoney)
exports('AcceptTrade', AcceptTrade)
exports('CancelTrade', CancelTrade)