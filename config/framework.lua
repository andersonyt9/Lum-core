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
        Framework.LogTransaction(source, "add_money", amount)
    end
    function Framework.RemoveMoney(source, amount)
        local player = ESX.GetPlayerFromId(source)
        if player then player.removeMoney(amount) end
        Framework.LogTransaction(source, "remove_money", amount)
    end
    function Framework.SpawnVehicle(source, model)
        TriggerClientEvent("Lum-core:spawnVehicle", source, model)
    end
    function Framework.Notify(source, message)
        TriggerClientEvent("esx:showNotification", source, message)
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
        Framework.LogTransaction(source, "add_money", amount)
    end
    function Framework.RemoveMoney(source, amount)
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.RemoveMoney("cash", amount) end
        Framework.LogTransaction(source, "remove_money", amount)
    end
    function Framework.SpawnVehicle(source, model)
        TriggerClientEvent("Lum-core:spawnVehicle", source, model)
    end
    function Framework.Notify(source, message)
        TriggerClientEvent("QBCore:Notify", source, message)
    end
elseif Config.Framework == "vRP" then
    local vRP = Proxy.getInterface("vRP")
    local vRPclient = Tunnel.getInterface("vRP", "Lum-core")
    function Framework.GetPlayer(source)
        local user_id = vRP.getUserId({source})
        return { user_id = user_id, source = source }
    end
    function Framework.GetMoney(source)
        local user_id = vRP.getUserId({source})
        return user_id and vRP.getMoney({user_id}) or 0
    end
    function Framework.AddMoney(source, amount)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.giveMoney({user_id, amount}) end
        Framework.LogTransaction(source, "add_money", amount)
    end
    function Framework.RemoveMoney(source, amount)
        local user_id = vRP.getUserId({source})
        if user_id then vRP.tryPayment({user_id, amount}) end
        Framework.LogTransaction(source, "remove_money", amount)
    end
    function Framework.SpawnVehicle(source, model)
        vRPclient.spawnVehicle(source, {model})
    end
    function Framework.Notify(source, message)
        vRPclient.notify(source, {message})
    end
end

function Framework.LogTransaction(source, action, amount)
    local player = Framework.GetPlayer(source)
    if player then
        PerformHttpRequest(Config.Webhook, function() end, "POST", json.encode({
            username = "Lum Core",
            content = string.format("**%s** realizou a ação **%s** no valor de **$%d**", GetPlayerName(source), action, amount)
        }), { ["Content-Type"] = "application/json" })
    end
end