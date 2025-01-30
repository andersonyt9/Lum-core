RegisterNetEvent("Lum-core:getPlayerData")
AddEventHandler("Lum-core:getPlayerData", function()
    local src = source
    local player = Framework.GetPlayer(src)
    if player then
        TriggerClientEvent("Lum-core:receivePlayerData", src, player)
    end
end)

RegisterNetEvent("Lum-core:getPlayerMoney")
AddEventHandler("Lum-core:getPlayerMoney", function()
    local src = source
    local money = Framework.GetMoney(src)
    TriggerClientEvent("Lum-core:receivePlayerMoney", src, money)
end)

RegisterNetEvent("Lum-core:addMoney")
AddEventHandler("Lum-core:addMoney", function(amount)
    local src = source
    Framework.AddMoney(src, amount)
end)

RegisterNetEvent("Lum-core:removeMoney")
AddEventHandler("Lum-core:removeMoney", function(amount)
    local src = source
    Framework.RemoveMoney(src, amount)
end)
