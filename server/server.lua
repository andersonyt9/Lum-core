RegisterNetEvent("Lum-core:getPlayerData")
AddEventHandler("Lum-core:getPlayerData", function()
    local src = source
    local player = Framework.GetPlayer(src)
    if player then
        TriggerClientEvent("Lum-core:receivePlayerData", src, player)
    end
end)