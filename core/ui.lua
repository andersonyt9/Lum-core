local UI = {}

-- Função para abrir um menu de interface
function UI.OpenMenu(playerId, title, options)
    TriggerClientEvent('Lum-core:OpenMenu', playerId, title, options)
end

-- Função para abrir a interface de configuração
function UI.OpenConfig(playerId)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'openConfig'
    })
end

-- Função para salvar a configuração via NUI
RegisterNUICallback('saveConfig', function(data, cb)
    local success, errorMessage = Config.Set('framework', data.framework)
    if success then
        Config.Set('webhooks.logs', data.webhooks.logs)
        Config.Save()
        cb({ success = true })
    else
        cb({ success = false, error = errorMessage })
    end
end)

-- Retorna a interface de UI
return UI