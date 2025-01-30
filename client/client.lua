RegisterNetEvent("Lum-core:receivePlayerData")
AddEventHandler("Lum-core:receivePlayerData", function(player)
    print("Player Data:", json.encode(player))
end)

print("Sistema multi-framework carregado. Framework atual:" .. Config.Framework)