local currentHouse = nil

function OpenHouseMenu(houseId)
    local house = exports['lum-core']:GetHouses()[houseId]
    if not house then return end

    currentHouse = house

    -- Exibe a UI da casa
    SendNUIMessage({
        action = 'openHouseMenu',
        house = house
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('buyHouse', function(data, cb)
    local success, message = exports['lum-core']:BuyHouse(PlayerId(), currentHouse.id)
    cb({ success = success, message = message })
end)

RegisterNUICallback('sellHouse', function(data, cb)
    local success, message = exports['lum-core']:SellHouse(PlayerId())
    cb({ success = success, message = message })
end)

RegisterNUICallback('closeHouseMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)