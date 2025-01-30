RegisterNetEvent("Lum-core:receivePlayerData")
AddEventHandler("Lum-core:receivePlayerData", function(player)
    print("Player Data:", json.encode(player))
end)

RegisterNetEvent("Lum-core:receivePlayerMoney")
AddEventHandler("Lum-core:receivePlayerMoney", function(money)
    print("Player Money:", money)
end)

RegisterNetEvent("Lum-core:spawnVehicle")
AddEventHandler("Lum-core:spawnVehicle", function(model)
    local playerPed = PlayerPedId()
    local vehicleHash = GetHashKey(model)
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end
    local vehicle = CreateVehicle(vehicleHash, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, false)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    SetModelAsNoLongerNeeded(vehicleHash)
end)

RegisterNetEvent("Lum-core:notify")
AddEventHandler("Lum-core:notify", function(message)
    print("Notificação: " .. message)
end)

print("Sistema multi-framework carregado. Framework atual: " .. Config.Framework)