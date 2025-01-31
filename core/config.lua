Config = {}

-- Escolha o framework que deseja usar: 'esx', 'vrp', 'qbcore', 'standalone', 'custom'
Config.Framework = 'vrp' -- Altere para o framework desejado

-- URLs dos webhooks
Config.Webhooks = {
    logs = 'https://discord.com/api/webhooks/SEU_WEBHOOK_LOGS', -- Webhook para logs gerais
    economy = 'https://discord.com/api/webhooks/SEU_WEBHOOK_ECONOMY', -- Webhook para logs de economia
    inventory = 'https://discord.com/api/webhooks/SEU_WEBHOOK_INVENTORY', -- Webhook para logs de inventário
    properties = 'https://discord.com/api/webhooks/SEU_WEBHOOK_PROPERTIES', -- Webhook para logs de propriedades
    vehicles = 'https://discord.com/api/webhooks/SEU_WEBHOOK_VEHICLES', -- Webhook para logs de veículos
    clans = 'https://discord.com/api/webhooks/SEU_WEBHOOK_CLANS', -- Webhook para logs de clãs
    trades = 'https://discord.com/api/webhooks/SEU_WEBHOOK_TRADES', -- Webhook para logs de comércio
    auctions = 'https://discord.com/api/webhooks/SEU_WEBHOOK_AUCTIONS', -- Webhook para logs de leilões
    achievements = 'https://discord.com/api/webhooks/SEU_WEBHOOK_ACHIEVEMENTS', -- Webhook para logs de conquistas
    globalEvents = 'https://discord.com/api/webhooks/SEU_WEBHOOK_GLOBAL_EVENTS', -- Webhook para logs de eventos globais
    missions = 'https://discord.com/api/webhooks/SEU_WEBHOOK_MISSIONS', -- Webhook para logs de missões
    levels = 'https://discord.com/api/webhooks/SEU_WEBHOOK_LEVELS', -- Webhook para logs de níveis
    dailyRewards = 'https://discord.com/api/webhooks/SEU_WEBHOOK_DAILY_REWARDS', -- Webhook para logs de recompensas diárias
    friends = 'https://discord.com/api/webhooks/SEU_WEBHOOK_FRIENDS', -- Webhook para logs de amizades
    groups = 'https://discord.com/api/webhooks/SEU_WEBHOOK_GROUPS', -- Webhook para logs de grupos
    clanBattles = 'https://discord.com/api/webhooks/SEU_WEBHOOK_CLAN_BATTLES', -- Webhook para logs de batalhas entre clãs
    shop = 'https://discord.com/api/webhooks/SEU_WEBHOOK_SHOP', -- Webhook para logs de loja
    commands = 'https://discord.com/api/webhooks/SEU_WEBHOOK_COMMANDS', -- Webhook para logs de comandos
    permissions = 'https://discord.com/api/webhooks/SEU_WEBHOOK_PERMISSIONS', -- Webhook para logs de permissões
    notifications = 'https://discord.com/api/webhooks/SEU_WEBHOOK_NOTIFICATIONS', -- Webhook para logs de notificações
    ui = 'https://discord.com/api/webhooks/SEU_WEBHOOK_UI', -- Webhook para logs de UI
    database = 'https://discord.com/api/webhooks/SEU_WEBHOOK_DATABASE', -- Webhook para logs de banco de dados
}

local Config = {}

-- Função para carregar o arquivo de configuração
function Config.Load()
    local configFile = LoadResourceFile(GetCurrentResourceName(), 'config.json')
    if configFile then
        Config.data = json.decode(configFile)
    else
        Config.data = {
            framework = 'vrp',
            webhooks = {
                logs = '',
                economy = '',
                inventory = ''
            },
            permissions = {
                admin = {
                    addMoney = true,
                    removeMoney = true,
                    setJob = true
                },
                user = {
                    addMoney = false,
                    removeMoney = false,
                    setJob = false
                }
            }
        }
        SaveResourceFile(GetCurrentResourceName(), 'config.json', json.encode(Config.data, { indent = true }), -1)
    end
end

-- Função para salvar o arquivo de configuração
function Config.Save()
    SaveResourceFile(GetCurrentResourceName(), 'config.json', json.encode(Config.data, { indent = true }), -1)
end

-- Carrega a configuração ao iniciar
Config.Load()

-- Retorna a interface de configuração
return Config