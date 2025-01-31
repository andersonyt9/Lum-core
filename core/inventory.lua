local Inventory = {}
local Webhook = require 'core.webhook'
local Config = require 'core.config'

-- Função para adicionar um item ao inventário de um jogador
function Inventory.AddItem(playerId, item, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    local success = frameworkModule.AddItemToPlayer(playerId, item, amount)
    if success then
        Logs.Write('INFO', string.format('Jogador %d recebeu %d %s.', playerId, amount, item))
        Webhook.SendLog(Config.Webhooks.inventory, 'Inventário - Adicionar Item', string.format('Jogador %d recebeu %d %s.', playerId, amount, item), 65280) -- Verde
    else
        Logs.Write('ERROR', string.format('Falha ao adicionar %d %s ao inventário do jogador %d.', amount, item, playerId))
        Webhook.SendLog(Config.Webhooks.inventory, 'Inventário - Erro', string.format('Falha ao adicionar %d %s ao inventário do jogador %d.', amount, item, playerId), 16711680) -- Vermelho
    end
    return success
end

-- Função para remover um item do inventário de um jogador
function Inventory.RemoveItem(playerId, item, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    local success = frameworkModule.RemoveItemFromPlayer(playerId, item, amount)
    if success then
        Logs.Write('INFO', string.format('Jogador %d perdeu %d %s.', playerId, amount, item))
        Webhook.SendLog(Config.Webhooks.inventory, 'Inventário - Remover Item', string.format('Jogador %d perdeu %d %s.', playerId, amount, item), 65280) -- Verde
    else
        Logs.Write('ERROR', string.format('Falha ao remover %d %s do inventário do jogador %d.', amount, item, playerId))
        Webhook.SendLog(Config.Webhooks.inventory, 'Inventário - Erro', string.format('Falha ao remover %d %s do inventário do jogador %d.', amount, item, playerId), 16711680) -- Vermelho
    end
    return success
end

-- Retorna a interface de inventário
return Inventory