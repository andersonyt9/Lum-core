local Config = require 'config.languages'
local Locales = {}

-- Carregar arquivos de tradução
for _, lang in ipairs(Config.SupportedLanguages) do
    Locales[lang] = json.decode(LoadResourceFile(GetCurrentResourceName(), ('locales/%s.json'):format(lang)))
end

function SetPlayerLanguage(playerId, lang)
    if Locales[lang] then
        -- Salvar no banco de dados (exemplo com oxmysql)
        MySQL.update('UPDATE users SET language = ? WHERE identifier = ?', {lang, Framework.getPlayerIdentifier(playerId)})
    end
end

function GetPlayerLanguage(playerId)
    local identifier = Framework.getPlayerIdentifier(playerId)
    local result = MySQL.single.await('SELECT language FROM users WHERE identifier = ?', {identifier})
    return result.language or Config.DefaultLanguage
end

local playerLanguageCache = {}

function GetPlayerLanguage(playerId)
    if playerLanguageCache[playerId] then
        return playerLanguageCache[playerId]
    end
    playerLanguageCache[playerId] = result.language
    return playerLanguageCache[playerId]
end