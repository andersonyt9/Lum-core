local shops = {
    {
        name = "Loja de Alimentos",
        items = {
            { item = 'bread', label = 'Pão', price = 10 },
            { item = 'water', label = 'Água', price = 5 }
        }
    },
    {
        name = "Loja de Armas",
        items = {
            { item = 'weapon_pistol', label = 'Pistola', price = 1000 },
            { item = 'ammo-9', label = 'Munição 9mm', price = 50 }
        }
    }
}

function GetShops()
    return shops
end

function BuyItem(playerId, shopIndex, itemIndex)
    local shop = shops[shopIndex]
    local item = shop.items[itemIndex]

    if not shop or not item then
        return false, "Item inválido."
    end

    local playerMoney = exports['lum-core']:GetPlayerMoney(playerId)
    if playerMoney >= item.price then
        exports['lum-core']:RemoveMoney(playerId, item.price)
        exports['lum-core']:AddItem(playerId, item.item, 1)
        return true, "Compra realizada com sucesso!"
    else
        return false, "Dinheiro insuficiente."
    end
end

-- Exporta as funções
exports('GetShops', GetShops)
exports('BuyItem', BuyItem)