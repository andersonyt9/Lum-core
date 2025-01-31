local Economy = {}
local Webhook = require 'core.webhook'
local Config = require 'core.config'

-- Função para adicionar dinheiro a um jogador
function Economy.AddMoney(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    local success = frameworkModule.AddMoneyToPlayer(playerId, amount)
    if success then
        Logs.Write('INFO', string.format('Jogador %d recebeu %d de dinheiro.', playerId, amount))
        Webhook.SendLog(Config.Webhooks.economy, 'Economia - Adicionar Dinheiro', string.format('Jogador %d recebeu %d de dinheiro.', playerId, amount), 65280) -- Verde
    else
        Logs.Write('ERROR', string.format('Falha ao adicionar dinheiro ao jogador %d.', playerId))
        Webhook.SendLog(Config.Webhooks.economy, 'Economia - Erro', string.format('Falha ao adicionar dinheiro ao jogador %d.', playerId), 16711680) -- Vermelho
    end
    return success
end

-- Função para remover dinheiro de um jogador
function Economy.RemoveMoney(playerId, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    local success = frameworkModule.RemoveMoneyFromPlayer(playerId, amount)
    if success then
        Logs.Write('INFO', string.format('Jogador %d perdeu %d de dinheiro.', playerId, amount))
        Webhook.SendLog(Config.Webhooks.economy, 'Economia - Remover Dinheiro', string.format('Jogador %d perdeu %d de dinheiro.', playerId, amount), 65280) -- Verde
    else
        Logs.Write('ERROR', string.format('Falha ao remover dinheiro do jogador %d.', playerId))
        Webhook.SendLog(Config.Webhooks.economy, 'Economia - Erro', string.format('Falha ao remover dinheiro do jogador %d.', playerId), 16711680) -- Vermelho
    end
    return success
end

-- Retorna a interface de economia
return Economy