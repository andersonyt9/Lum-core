local Economy = {}

function Economy.AddMoney(playerId, amount)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.addMoney(amount)
    elseif Config.Framework == 'qbcore' then
        local player = QBCore.Functions.GetPlayer(playerId)
        player.Functions.AddMoney('cash', amount)
    end
    exports['lum-core']:LogWebhook('economy', string.format("Jogador %s recebeu $%s", Framework.getPlayerIdentifier(playerId), amount))
end

return Economy