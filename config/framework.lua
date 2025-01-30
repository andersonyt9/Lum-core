Framework = {}

if Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
    function Framework.GetPlayer(source)
        return ESX.GetPlayerFromId(source)
    end
    function Framework.GetMoney(source)
        local player = ESX.GetPlayerFromId(source)
        return player and player.getMoney() or 0
    end
    function Framework.AddMoney(source, amount)
        local player = ESX.GetPlayerFromId(source)
        if player then player.addMoney(amount) end
    end
    function Framework.RemoveMoney(source, amount)
        local player = ESX.GetPlayerFromId(source)
        if player then player.removeMoney(amount) end
    end
    function Framework.HasPermission(source, perm)
        local player = ESX.GetPlayerFromId(source)
        return player and player.getGroup() == perm
    end
    function Framework.AddItem(source, item, count)
        local player = ESX.GetPlayerFromId(source)
        if player then player.addInventoryItem(item, count) end
    end
    function Framework.RemoveItem(source, item, count)
        local player = ESX.GetPlayerFromId(source)
        if player then player.removeInventoryItem(item, count) end
    end
elseif Config.Framework == "QBCore" then
    QBCore = exports["qb-core"]:GetCoreObject()
    function Framework.GetPlayer(source)
        return QBCore.Functions.GetPlayer(source)
    end
    function Framework.GetMoney(source)
        local player = QBCore.Functions.GetPlayer(source)
        return player and player.PlayerData.money.cash or 0
    end
    function Framework.AddMoney(source, amount)
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.AddMoney("cash", amount) end
    end
    function Framework.RemoveMoney(source, amount)
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.RemoveMoney("cash", amount) end
    end
    function Framework.HasPermission(source, perm)
        local player = QBCore.Functions.GetPlayer(source)
        return player and player.PlayerData.job.name == perm
    end
    function Framework.AddItem(source, item, count)
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.AddItem(item, count) end
    end
    function Framework.RemoveItem(source, item, count)
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.RemoveItem(item, count) end
    end
elseif Config.Framework == "vRP" then
    local vRP = Proxy.getInterface("vRP")
    local vRPclient = Tunnel.getInterface("vRP", "Lum-core")
    function Framework.GetPlayer(source)
        local user_id = vRP.getUserId({source})
        if user_id then
            return { user_id = user_id, source = source }
        end
        return nil
    end
    function Framework.GetMoney(source)
        local user_id = vRP.getUserId({source})
        return user_id and vRP.getMoney({user_id}) or 0
    end
    function Framework.AddMoney(source, amount)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.giveMoney({user_id, amount}) end
    end
    function Framework.RemoveMoney(source, amount)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.tryPayment({user_id, amount}) end
    end
    function Framework.HasPermission(source, perm)
        local user_id = vRP.getUserId({source})
        return user_id and vRP.hasPermission({user_id, perm})
    end
    function Framework.AddItem(source, item, count)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.giveInventoryItem({user_id, item, count}) end
    end
    function Framework.RemoveItem(source, item, count)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.tryGetInventoryItem({user_id, item, count}) end
    end
end