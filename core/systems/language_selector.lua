local Framework = require 'core/integrations/' .. Config.Framework
local LogWebhook = exports['lum-core']:LogWebhook
local SetPlayerLanguage = exports['lum-core']:SetPlayerLanguage

-- Comando para alterar idioma (/lang [en/pt/es])
RegisterCommand('lang', function(source, args)
    local playerId = source
    local lang = args[1] or 'en'

    if not Config.SupportedLanguages[lang] then
        Framework.notify(playerId, Locales[GetPlayerLanguage(playerId)]['invalid_lang'])
        return
    end

    SetPlayerLanguage(playerId, lang)
    Framework.notify(playerId, Locales[lang]['lang_updated'])
    LogWebhook('language_change', string.format("Jogador %s alterou o idioma para: %s", Framework.getPlayerIdentifier(playerId), lang))
end, false)