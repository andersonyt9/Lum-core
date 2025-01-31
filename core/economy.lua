local Economy = {}

-- Função para obter o dinheiro de um jogador
function Economy.GetMoney(playerId)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.GetPlayerInfo(playerId).money
end

-- Função para adicionar dinheiro a um jogador
function Economy.AddMoney(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.AddMoneyToPlayer(playerId, amount)
end

-- Função para remover dinheiro de um jogador
function Economy.RemoveMoney(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.RemoveMoneyFromPlayer(playerId, amount)
end

-- Função para obter o saldo bancário de um jogador
function Economy.GetBankBalance(playerId)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.GetPlayerBankBalance(playerId)
end

-- Função para depositar dinheiro no banco
function Economy.DepositToBank(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.DepositMoneyToBank(playerId, amount)
end

-- Função para sacar dinheiro do banco
function Economy.WithdrawFromBank(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.WithdrawMoneyFromBank(playerId, amount)
end

-- Retorna a interface de economia
return Economy