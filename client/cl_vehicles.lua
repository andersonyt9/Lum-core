RegisterNetEvent('lum-core:spawnVehicle')
AddEventHandler('lum-core:spawnVehicle', function(model, coords)
    local vehicleHash = GetHashKey(model)
    RequestModel(vehicleHash)

    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end

    local vehicle = CreateVehicle(vehicleHash, coords.x, coords.y, coords.z, coords.heading, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
end)