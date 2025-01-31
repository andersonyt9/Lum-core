local UI = {}

-- Função para abrir um menu de interface
function UI.OpenMenu(playerId, title, options)
    TriggerClientEvent('Lum-core:OpenMenu', playerId, title, options)
end

-- Retorna a interface de UI
return UI