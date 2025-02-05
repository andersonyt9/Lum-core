local Framework = require 'core/integrations/' .. Config.Framework -- Carrega o adaptador do framework configurado
local LogWebhook = exports['lum-core']:LogWebhook -- Função de log global
local GetPlayerLanguage = exports['lum-core']:GetPlayerLanguage -- Função de idioma

-- Evento principal quando o jogador se conecta
AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()
    local playerId = source
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamHex = identifiers[1] or 'Desconhecido'

    -- Aguardar 1 segundo para garantir que tudo esteja carregado
    Citizen.Wait(1000)

    deferrals.update("[Lum Core] Carregando suas informações...")

    -- Verificar se o identificador do framework está disponível
    local frameworkIdentifier = Framework.getPlayerIdentifier(playerId)
    if not frameworkIdentifier then
        LogWebhook('player_connect_error', 'Jogador não identificado: ' .. name)
        deferrals.done("[ERRO] Seu identificador não foi carregado. Reinicie o FiveM.")
        return
    end

    -- Obter idioma do jogador (do banco de dados ou padrão)
    local playerLanguage = GetPlayerLanguage(playerId) or Config.DefaultLanguage

    -- Notificação de boas-vindas no idioma escolhido
    local welcomeMessage = Locales[playerLanguage]['welcome'] or Locales['en']['welcome']
    Framework.notify(playerId, welcomeMessage)

    -- Log detalhado no Discord
    LogWebhook('player_connect', string.format(
        "**%s** entrou no servidor.\n**ID do Framework**: %s\n**Steam Hex**: ||%s||\n**Idioma**: %s",
        name, frameworkIdentifier, steamHex, playerLanguage
    ))

    deferrals.done()
end)