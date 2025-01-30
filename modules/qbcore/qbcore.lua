local QBCore = exports['qb-core']:GetCoreObject()

-- Função para obter informações do jogador
function GetPlayerInfo(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return {
            identifier = Player.PlayerData.citizenid,
            name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
            job = Player.PlayerData.job.name,
            money = Player.PlayerData.money.cash,
            bank = Player.PlayerData.money.bank
        }
    else
        return nil
    end
end

-- Função para obter o inventário de um jogador
function GetPlayerInventory(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return Player.PlayerData.items
    else
        return nil
    end
end

-- Função para adicionar um item ao inventário de um jogador
function AddItemToPlayer(playerId, item, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.AddItem(item, amount)
        return true
    else
        return false
    end
end

-- Função para remover um item do inventário de um jogador
function RemoveItemFromPlayer(playerId, item, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.RemoveItem(item, amount)
        return true
    else
        return false
    end
end

-- Função para adicionar dinheiro a um jogador
function AddMoneyToPlayer(playerId, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.AddMoney('cash', amount)
        return true
    else
        return false
    end
end

-- Função para remover dinheiro de um jogador
function RemoveMoneyFromPlayer(playerId, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.RemoveMoney('cash', amount)
        return true
    else
        return false
    end
end

-- Função para obter o emprego atual de um jogador
function GetPlayerJob(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return Player.PlayerData.job
    else
        return nil
    end
end

-- Função para mudar o emprego de um jogador
function SetPlayerJob(playerId, job, grade)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.SetJob(job, grade)
        return true
    else
        return false
    end
end

-- Função para spawnar um veículo para um jogador
function SpawnVehicleForPlayer(playerId, model, coords, heading)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        local vehicle = QBCore.Functions.SpawnVehicle(model, coords, heading)
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
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return Player.PlayerData.money.bank
    else
        return nil
    end
end

-- Função para depositar dinheiro no banco
function DepositMoneyToBank(playerId, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.RemoveMoney('cash', amount)
        Player.Functions.AddMoney('bank', amount)
        return true
    else
        return false
    end
end

-- Função para sacar dinheiro do banco
function WithdrawMoneyFromBank(playerId, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.RemoveMoney('bank', amount)
        Player.Functions.AddMoney('cash', amount)
        return true
    else
        return false
    end
end

-- Função para obter a gang/facção de um jogador
function GetPlayerGang(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        return Player.PlayerData.gang
    else
        return nil
    end
end

-- Função para mudar a gang/facção de um jogador
function SetPlayerGang(playerId, gang, grade)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.SetGang(gang, grade)
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