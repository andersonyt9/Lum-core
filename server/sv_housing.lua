local houses = {
    { id = 1, label = 'Casa 1', price = 100000, coords = vector3(-784.5, 459.9, 100.2) },
    { id = 2, label = 'Casa 2', price = 150000, coords = vector3(-774.5, 449.9, 100.2) }
}

local playerHouses = {}

function BuyHouse(playerId, houseId)
    local house = houses[houseId]
    if not house then return false, "Casa inválida." end

    local playerMoney = exports['lum-core']:GetPlayerMoney(playerId)
    if playerMoney >= house.price then
        exports['lum-core']:RemoveMoney(playerId, house.price)
        playerHouses[playerId] = house
        return true, "Casa comprada com sucesso!"
    else
        return false, "Dinheiro insuficiente."
    end
end

function SellHouse(playerId)
    local house = playerHouses[playerId]
    if not house then return false, "Você não possui uma casa." end

    exports['lum-core']:AddMoney(playerId, house.price * 0.8) -- Vende por 80% do valor
    playerHouses[playerId] = nil
    return true, "Casa vendida com sucesso!"
end

function GetPlayerHouse(playerId)
    return playerHouses[playerId]
end

-- Exporta as funções
exports('BuyHouse', BuyHouse)
exports('SellHouse', SellHouse)
exports('GetPlayerHouse', GetPlayerHouse)