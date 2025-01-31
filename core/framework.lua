local Framework = {}

-- Carrega a configuração
local Config = require 'core.config'

-- Carrega o sistema de eventos
local Events = require 'core.events'

-- Carrega o sistema de logs
local Logs = require 'core.logs'

-- Carrega o sistema de permissões
local Permissions = require 'core.permissions'

-- Carrega o sistema de comandos
local Commands = require 'core.commands'

-- Carrega o sistema de notificações
local Notifications = require 'core.notifications'

-- Carrega o sistema de UI
local UI = require 'core.ui'

-- Carrega o sistema de banco de dados
local Database = require 'core.database'

-- Carrega o sistema de economia
local Economy = require 'core.economy'

-- Carrega o sistema de inventário
local Inventory = require 'core.inventory'

-- Carrega o sistema de missões
local Missions = require 'core.missions'

-- Carrega o sistema de loja
local Shop = require 'core.shop'

-- Carrega o sistema de níveis
local Levels = require 'core.levels'

-- Carrega o sistema de recompensas diárias
local DailyRewards = require 'core.dailyrewards'

-- Carrega o sistema de amizades
local Friends = require 'core.friends'

-- Carrega o sistema de grupos
local Groups = require 'core.groups'

-- Carrega o sistema de clãs
local Clans = require 'core.clans'

-- Carrega o sistema de batalhas entre clãs
local ClanBattles = require 'core.clanbattles'

-- Carrega o sistema de conquistas
local Achievements = require 'core.achievements'

-- Carrega o sistema de eventos globais
local GlobalEvents = require 'core.globalevents'

-- Carrega o sistema de comércio
local Trade = require 'core.trade'

-- Carrega o sistema de leilões
local Auction = require 'core.auction'

-- Carrega o sistema de propriedades
local Properties = require 'core.properties'

-- Carrega o sistema de veículos
local Vehicles = require 'core.vehicles'

-- Função para carregar o módulo do framework
function Framework.loadModule()
    local frameworkName = Config.Framework
    local modulePath = 'modules/' .. frameworkName .. '/' .. frameworkName .. '.lua'

    -- Verifica se o módulo existe
    if not LoadResourceFile(GetCurrentResourceName(), modulePath) then
        error(('O módulo para o framework "%s" não foi encontrado.'):format(frameworkName))
    end

    -- Carrega o módulo
    local module = require('modules/' .. frameworkName .. '/' .. frameworkName)
    return module
end

-- Inicializa o framework
function Framework.init()
    local module = Framework.loadModule()
    return module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards, Friends, Groups, Clans, ClanBattles, Achievements, GlobalEvents, Trade, Auction, Properties, Vehicles
end

return Framework