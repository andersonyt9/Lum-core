local Framework = {}

-- Carrega a configuração
local Config = require 'core.config'

-- Carrega o sistema de eventos
local Events = require 'core.events'

-- Função para carregar o módulo do framework
function Framework.loadModule()
    local Lum-core = Config.Framework
    local modulePath = 'modules/' .. Lum-core .. '/' .. Lum-core .. '.lua'

    -- Verifica se o módulo existe
    if not LoadResourceFile(GetCurrentResourceName(), modulePath) then
        error(('O módulo para o framework "%s" não foi encontrado.'):format(Lum-core))
    end

    -- Carrega o módulo
    local module = require('modules/' .. Lum-core .. '/' .. Lum-core)
    return module
end

-- Inicializa o framework
function Framework.init()
    local module = Framework.loadModule()
    return module, Events
end

return Framework