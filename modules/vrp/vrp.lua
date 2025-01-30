local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- Função para obter informações do jogador
function GetPlayerInfo(playerId)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        return {
            identifier = user_id,
            name = GetPlayerName(playerId),
            job = vRP.getUserGroupByType({user_id, "job"}),
            money = vRP.getMoney({user_id}),
            bank = vRP.getBankMoney({user_id})
        }
    else
        return nil
    end
end

-- Função para obter o inventário de um jogador
function GetPlayerInventory(playerId)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        return vRP.getInventory({user_id})
    else
        return nil
    end
end

-- Função para adicionar um item ao inventário de um jogador
function AddItemToPlayer(playerId, item, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.giveInventoryItem({user_id, item, amount, true})
        return true
    else
        return false
    end
end

-- Função para remover um item do inventário de um jogador
function RemoveItemFromPlayer(playerId, item, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.tryGetInventoryItem({user_id, item, amount, true})
        return true
    else
        return false
    end
end

-- Função para adicionar dinheiro a um jogador
function AddMoneyToPlayer(playerId, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.giveMoney({user_id, amount})
        return true
    else
        return false
    end
end

-- Função para remover dinheiro de um jogador
function RemoveMoneyFromPlayer(playerId, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.tryPayment({user_id, amount})
        return true
    else
        return false
    end
end

-- Função para obter o emprego atual de um jogador
function GetPlayerJob(playerId)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        return vRP.getUserGroupByType({user_id, "job"})
    else
        return nil
    end
end

-- Função para mudar o emprego de um jogador
function SetPlayerJob(playerId, job, grade)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.addUserGroup({user_id, job})
        return true
    else
        return false
    end
end

-- Função para spawnar um veículo para um jogador
function SpawnVehicleForPlayer(playerId, model, coords, heading)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true)
        if vehicle then
            return vehicle
        else
            return nil
        end
    else
        return nil
    end
end

-- Função para deletar um veículo
function DeleteVehicle(vehicle)
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        return true
    else
        return false
    end
end

-- Função para obter o saldo bancário de um jogador
function GetPlayerBankBalance(playerId)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        return vRP.getBankMoney({user_id})
    else
        return nil
    end
end

-- Função para depositar dinheiro no banco
function DepositMoneyToBank(playerId, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.setBankMoney({user_id, vRP.getBankMoney({user_id}) + amount})
        return true
    else
        return false
    end
end

-- Função para sacar dinheiro do banco
function WithdrawMoneyFromBank(playerId, amount)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.setBankMoney({user_id, vRP.getBankMoney({user_id}) - amount})
        return true
    else
        return false
    end
end

-- Função para obter a gang/facção de um jogador
function GetPlayerGang(playerId)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        return vRP.getUserGroupByType({user_id, "gang"})
    else
        return nil
    end
end

-- Função para mudar a gang/facção de um jogador
function SetPlayerGang(playerId, gang, grade)
    local user_id = vRP.getUserId({playerId})
    if user_id then
        vRP.addUserGroup({user_id, gang})
        return true
    else
        return false
    end
end

-- Adiciona as novas funções ao retorno
return {
    GetPlayerInfo = GetPlayerInfo,
    GetPlayerInventory = GetPlayerInventory,
    AddItemToPlayer = AddItemToPlayer,
    RemoveItemFromPlayer = RemoveItemFromPlayer,
    AddMoneyToPlayer = AddMoneyToPlayer,
    RemoveMoneyFromPlayer = RemoveMoneyFromPlayer,
    GetPlayerJob = GetPlayerJob,
    SetPlayerJob = SetPlayerJob,
    SpawnVehicleForPlayer = SpawnVehicleForPlayer,
    DeleteVehicle = DeleteVehicle,
    GetPlayerBankBalance = GetPlayerBankBalance,
    DepositMoneyToBank = DepositMoneyToBank,
    WithdrawMoneyFromBank = WithdrawMoneyFromBank,
    GetPlayerGang = GetPlayerGang,
    SetPlayerGang = SetPlayerGang
}