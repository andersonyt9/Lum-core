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
    return module, Events, Logs, Permissions, Commands, Notifications, UI, Database
end

return Framework