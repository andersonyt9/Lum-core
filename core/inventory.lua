local Inventory = {}

-- Função para obter o inventário de um jogador
function Inventory.GetInventory(playerId)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.GetPlayerInventory(playerId)
end

-- Função para adicionar um item ao inventário de um jogador
function Inventory.AddItem(playerId, item, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.AddItemToPlayer(playerId, item, amount)
end

-- Função para remover um item do inventário de um jogador
function Inventory.RemoveItem(playerId, item, amount)
    local module = require 'core/framework'
    local frameworkModule = module.init()
    return frameworkModule.RemoveItemFromPlayer(playerId, item, amount)
end

-- Retorna a interface de inventário
return Inventory