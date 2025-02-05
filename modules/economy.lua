local Economy = {}

function Economy.GetMoney(playerId, type)
    if Config.Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        return type == 'bank' and xPlayer.getAccount('bank').money or xPlayer.getMoney()
    elseif Config.Framework == 'qbcore' then
        local player = QBCore.Functions.GetPlayer(playerId)
        return type == 'bank' and player.PlayerData.money['bank'] or player.PlayerData.money['cash']
    end
end