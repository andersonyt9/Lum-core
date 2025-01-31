local Shop = {}

-- Tabela para armazenar os itens da loja
local shopItems = {}

-- Função para adicionar um item à loja
function Shop.AddItem(itemId, itemData)
    shopItems[itemId] = itemData
end

-- Função para comprar um item
function Shop.BuyItem(playerId, itemId)
    local item = shopItems[itemId]
    if item then
        if Economy.GetMoney(playerId) >= item.price then
            Economy.RemoveMoney(playerId, item.price)
            Inventory.AddItem(playerId, item.item, item.amount)
            Logs.Write('INFO', string.format('Jogador %d comprou %s.', playerId, itemId))
            Notifications.Send(playerId, string.format('Você comprou %s.', item.item), 'success')
        else
            Logs.Write('WARNING', string.format('Jogador %d não tem dinheiro suficiente para comprar %s.', playerId, itemId))
            Notifications.Send(playerId, 'Dinheiro insuficiente.', 'error')
        end
    else
        Logs.Write('ERROR', string.format('Item %s não encontrado na loja.', itemId))
    end
end

-- Retorna a interface de loja
return Shop