local currentVehicle = nil

function OpenVehicleMenu()
    local vehicles = exports['lum-core']:GetPlayerVehicles(PlayerId())
    if not vehicles then return end

    -- Exibe a UI dos veículos
    SendNUIMessage({
        action = 'openVehicleMenu',
        vehicles = vehicles
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('spawnVehicle', function(data, cb)
    local success, message = exports['lum-core']:SpawnPlayerVehicle(PlayerId(), data.plate)
    cb({ success = success, message = message })
end)

RegisterNUICallback('closeVehicleMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)