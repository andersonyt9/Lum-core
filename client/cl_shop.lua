local currentShop = nil

function OpenShop(shopIndex)
    local shop = exports['lum-core']:GetShops()[shopIndex]
    if not shop then return end

    currentShop = shop

    -- Exibe a UI da loja
    SendNUIMessage({
        action = 'openShop',
        shop = shop
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('buyItem', function(data, cb)
    local success, message = exports['lum-core']:BuyItem(PlayerId(), currentShop, data.itemIndex)
    cb({ success = success, message = message })
end)

RegisterNUICallback('closeShop', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)