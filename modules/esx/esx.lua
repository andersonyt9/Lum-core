local ESX = nil

-- Inicializa o ESX
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

-- Função para obter informações do jogador
function GetPlayerInfo(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        return {
            identifier = xPlayer.identifier,
            name = xPlayer.getName(),
            job = xPlayer.job.name,
            money = xPlayer.getMoney(),
            bank = xPlayer.getAccount('bank').money
        }
    else
        return nil
    end
end

-- Função para obter o inventário de um jogador
function GetPlayerInventory(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        return xPlayer.getInventory()
    else
        return nil
    end
end

-- Função para adicionar um item ao inventário de um jogador
function AddItemToPlayer(playerId, item, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.addInventoryItem(item, amount)
        return true
    else
        return false
    end
end

-- Função para remover um item do inventário de um jogador
function RemoveItemFromPlayer(playerId, item, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.removeInventoryItem(item, amount)
        return true
    else
        return false
    end
end

-- Função para adicionar dinheiro a um jogador
function AddMoneyToPlayer(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.addMoney(amount)
        return true
    else
        return false
    end
end

-- Função para remover dinheiro de um jogador
function RemoveMoneyFromPlayer(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.removeMoney(amount)
        return true
    else
        return false
    end
end

-- Função para obter o emprego atual de um jogador
function GetPlayerJob(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        return xPlayer.job
    else
        return nil
    end
end

-- Função para mudar o emprego de um jogador
function SetPlayerJob(playerId, job, grade)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.setJob(job, grade)
        return true
    else
        return false
    end
end

-- Função para spawnar um veículo para um jogador
function SpawnVehicleForPlayer(playerId, model, coords, heading)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        local vehicle = ESX.Game.SpawnVehicle(model, coords, heading)
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
        ESX.Game.DeleteVehicle(vehicle)
        return true
    else
        return false
    end
end

-- Função para obter o saldo bancário de um jogador
function GetPlayerBankBalance(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        return xPlayer.getAccount('bank').money
    else
        return nil
    end
end

-- Função para depositar dinheiro no banco
function DepositMoneyToBank(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', amount)
        return true
    else
        return false
    end
end

-- Função para sacar dinheiro do banco
function WithdrawMoneyFromBank(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
        return true
    else
        return false
    end
end

-- Função para obter a gang/facção de um jogador
function GetPlayerGang(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        return xPlayer.getGang()
    else
        return nil
    end
end

-- Função para mudar a gang/facção de um jogador
function SetPlayerGang(playerId, gang, grade)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        xPlayer.setGang(gang, grade)
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