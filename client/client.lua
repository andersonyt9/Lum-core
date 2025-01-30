RegisterNetEvent("Lum-core:receivePlayerData")
AddEventHandler("Lum-core:receivePlayerData", function(player)
    print("Player Data:", json.encode(player))
end)

RegisterNetEvent("Lum-core:receivePlayerMoney")
AddEventHandler("Lum-core:receivePlayerMoney", function(money)
    print("Player Money:", money)
end)

print("Sistema multi-framework carregado. Framework atual: " .. Config.Framework)