Framework = {}

if Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
    function Framework.GetPlayer(source)
        return ESX.GetPlayerFromId(source)
    end
elseif Config.Framework == "QBCore" then
    QBCore = exports["qb-core"]:GetCoreObject()
    function Framework.GetPlayer(source)
        return QBCore.Functions.GetPlayer(source)
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
end