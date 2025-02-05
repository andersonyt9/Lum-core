fx_version 'cerulean'
game 'gta5'

name 'Lum Core'
author 'andersonyt99' --Discord
version '1.0.0'

shared_scripts {
    'config/frameworks.lua',
    'config/webhooks.lua',
    'config/languages.lua',
    'config/settings.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Importante para oxmysql
    'core/systems/log_manager.lua',
    'core/systems/language_manager.lua',
    'core/systems/database.lua',
    'utils/functions.lua',
    'utils/events.lua',
    'core/integrations/vrp/creative_v5.lua', -- Adaptador do vRP Creative v5
    'core/integrations/esx/esx.lua', -- Adaptador do ESX
    'core/integrations/qbcore/qbcore.lua', -- Adaptador do QBCore
    'core/integrations/qbox/qbox.lua' -- Adaptador do QBox
}

-- Dependências opcionais (ajuste conforme necessário)
dependencies {
    'oxmysql',
    'vrp' -- Se usar vRP Creative v5
}