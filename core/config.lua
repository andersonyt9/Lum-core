local Config = {}

-- Função para validar o valor de uma chave
function Config.Validate(key, value)
    if key == 'framework' then
        local supportedFrameworks = { 'esx', 'vrp', 'qbcore', 'standalone', 'custom' }
        for _, framework in ipairs(supportedFrameworks) do
            if value == framework then
                return true
            end
        end
        return false, 'Framework não suportado.'
    elseif key == 'webhooks.logs' or key == 'webhooks.economy' or key == 'webhooks.inventory' then
        if string.match(value, '^https://discord%.com/api/webhooks/%w+/%w+$') then
            return true
        else
            return false, 'URL do webhook inválida.'
        end
    elseif key == 'permissions.admin.addMoney' or key == 'permissions.admin.removeMoney' or key == 'permissions.admin.setJob' then
        if value == 'true' or value == 'false' then
            return true
        else
            return false, 'Valor deve ser "true" ou "false".'
        end
    else
        return true
    end
end

-- Função para definir um valor na configuração
function Config.Set(key, value)
    local keys = {}
    for k in string.gmatch(key, "[^.]+") do
        table.insert(keys, k)
    end

    local current = Config.data
    for i = 1, #keys - 1 do
        if not current[keys[i]] then
            current[keys[i]] = {}
        end
        current = current[keys[i]]
    end

    local isValid, errorMessage = Config.Validate(key, value)
    if isValid then
        current[keys[#keys]] = value
        return true
    else
        return false, errorMessage
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