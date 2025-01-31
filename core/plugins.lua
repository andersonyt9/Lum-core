local Plugins = {}

-- Tabela para armazenar os plugins carregados
local loadedPlugins = {}

-- Função para carregar um plugin
function Plugins.Load(pluginName)
    local pluginPath = 'plugins/' .. pluginName .. '/' .. pluginName .. '.lua'
    local configPath = 'plugins/' .. pluginName .. '/config.json'

    -- Carrega o arquivo de configuração do plugin
    local configFile = LoadResourceFile(GetCurrentResourceName(), configPath)
    if configFile then
        local config = json.decode(configFile)
        Plugins[pluginName] = config
    else
        Plugins[pluginName] = {}
    end

    -- Carrega o plugin
    if LoadResourceFile(GetCurrentResourceName(), pluginPath) then
        local plugin = require('plugins/' .. pluginName .. '/' .. pluginName)
        loadedPlugins[pluginName] = plugin
        Logs.Write('INFO', string.format('Plugin %s carregado com sucesso.', pluginName))
    else
        Logs.Write('ERROR', string.format('Falha ao carregar o plugin %s.', pluginName))
    end
end

-- Função para inicializar todos os plugins
function Plugins.Init()
    for pluginName, plugin in pairs(loadedPlugins) do
        if plugin.Init then
            plugin.Init()
            Logs.Write('INFO', string.format('Plugin %s inicializado.', pluginName))
        end
    end
end

-- Retorna a interface de plugins
return Plugins