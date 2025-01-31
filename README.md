---Aqui está um exemplo de como usar o framework para obter o inventário de um jogador---

-- Carrega o framework
local Framework = require 'core/framework'
local module = Framework.init()

-- Exemplo de uso
AddEventHandler('myFramework:getInventory', function(playerId)
    local inventory = module.GetPlayerInventory(playerId)
    if inventory then
        print(('Inventário do jogador %d: %s'):format(playerId, json.encode(inventory)))
    else
        print(('Jogador %d não encontrado.'):format(playerId))
    end
end)

---você pode usá-lo para realizar operações comuns, independentemente da framework subjacente. Exemplo de Uso---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events = Framework.init()

-- Exemplo: Obter informações do jogador
local playerId = source -- ID do jogador
local playerInfo = module.GetPlayerInfo(playerId)
if playerInfo then
    print(('Nome do jogador: %s'):format(playerInfo.name))
    print(('Dinheiro: %d'):format(playerInfo.money))
else
    print('Jogador não encontrado.')
end

-- Exemplo: Adicionar dinheiro ao jogador
local success = module.AddMoneyToPlayer(playerId, 100)
if success then
    print('Dinheiro adicionado com sucesso!')
else
    print('Falha ao adicionar dinheiro.')
end

---você pode usá-lo para realizar operações complexas, como gerenciar empregos, veículos e bancos. Exemplo de Uso Completo---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events = Framework.init()

-- Exemplo: Mudar o emprego de um jogador
local playerId = source -- ID do jogador
local success = module.SetPlayerJob(playerId, 'police', 1)
if success then
    print('Emprego alterado com sucesso!')
else
    print('Falha ao alterar o emprego.')
end

-- Exemplo: Spawnar um veículo para o jogador
local vehicle = module.SpawnVehicleForPlayer(playerId, 'police', vector3(0, 0, 0), 0.0)
if vehicle then
    print('Veículo spawnado com sucesso!')
else
    print('Falha ao spawnar o veículo.')
end

-- Exemplo: Depositar dinheiro no banco
local success = module.DepositMoneyToBank(playerId, 1000)
if success then
    print('Dinheiro depositado com sucesso!')
else
    print('Falha ao depositar dinheiro.')
end

---você pode usá-lo para realizar operações complexas, como gerenciar gangs, facções e muito mais, Exemplo de Uso Completo---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events = Framework.init()

-- Exemplo: Mudar a gang/facção de um jogador
local playerId = source -- ID do jogador
local success = module.SetPlayerGang(playerId, 'ballas', 1)
if success then
    print('Gang alterada com sucesso!')
else
    print('Falha ao alterar a gang.')
end

-- Exemplo: Obter informações da gang/facção de um jogador
local gangInfo = module.GetPlayerGang(playerId)
if gangInfo then
    print(('Gang do jogador: %s'):format(gangInfo.name))
else
    print('Jogador não encontrado ou não faz parte de uma gang.')
end

---Exemplo de Uso do Sistema de Logs----

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs = Framework.init()

-- Exemplo: Mudar o emprego de um jogador e registrar a ação
local playerId = source -- ID do jogador
local success = module.SetPlayerJob(playerId, 'police', 1)
if success then
    Logs.Write('INFO', string.format('Jogador %d mudou de emprego para police.', playerId))
    print('Emprego alterado com sucesso!')
else
    Logs.Write('ERROR', string.format('Falha ao alterar o emprego do jogador %d.', playerId))
    print('Falha ao alterar o emprego.')
end


---Exemplo de Uso do Sistema de Permissões---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions = Framework.init()

-- Exemplo: Verificar permissão antes de mudar o emprego de um jogador
local playerId = source -- ID do jogador
if Permissions.HasPermission(playerId, 'admin') then
    local success = module.SetPlayerJob(playerId, 'police', 1)
    if success then
        Logs.Write('INFO', string.format('Jogador %d mudou de emprego para police.', playerId))
        print('Emprego alterado com sucesso!')
    else
        Logs.Write('ERROR', string.format('Falha ao alterar o emprego do jogador %d.', playerId))
        print('Falha ao alterar o emprego.')
    end
else
    Logs.Write('WARNING', string.format('Jogador %d tentou mudar de emprego sem permissão.', playerId))
    print('Você não tem permissão para realizar esta ação.')
end

---Exemplo de Uso do Sistema de Comandos---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands = Framework.init()

-- Exemplo: Comando para mudar o emprego de um jogador
Commands.Register('setjob', function(playerId, args)
    local targetId = tonumber(args[1])
    local job = args[2]
    local grade = tonumber(args[3])

    if targetId and job and grade then
        local success = module.SetPlayerJob(targetId, job, grade)
        if success then
            Logs.Write('INFO', string.format('Jogador %d mudou de emprego para %s (Grade: %d).', targetId, job, grade))
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^2Sucesso', string.format('Emprego alterado para %s (Grade: %d).', job, grade) } })
        else
            Logs.Write('ERROR', string.format('Falha ao alterar o emprego do jogador %d.', targetId))
            TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', 'Falha ao alterar o emprego.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', playerId, { args = { '^1Erro', 'Uso correto: /setjob <ID> <Emprego> <Grade>' } })
    end
end, 'admin')


---Exemplo de Uso do Sistema de Notificações---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications = Framework.init()

-- Exemplo: Mudar o emprego de um jogador e enviar uma notificação
local playerId = source -- ID do jogador
local success = module.SetPlayerJob(playerId, 'police', 1)
if success then
    Logs.Write('INFO', string.format('Jogador %d mudou de emprego para police.', playerId))
    Notifications.Send(playerId, 'Emprego alterado com sucesso!', 'success')
else
    Logs.Write('ERROR', string.format('Falha ao alterar o emprego do jogador %d.', playerId))
    Notifications.Send(playerId, 'Falha ao alterar o emprego.', 'error')
end

---Exemplo de Uso do Sistema de UI---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI = Framework.init()

-- Exemplo: Abrir um menu de interface para mudar o emprego de um jogador
local playerId = source -- ID do jogador
local options = {
    { label = 'Polícia', value = 'police' },
    { label = 'Médico', value = 'ambulance' },
    { label = 'Mecânico', value = 'mechanic' }
}

UI.OpenMenu(playerId, 'Escolha um emprego', options)

-- Evento para lidar com a seleção do menu
RegisterNetEvent('myFramework:MenuSelect')
AddEventHandler('myFramework:MenuSelect', function(playerId, selectedValue)
    local success = module.SetPlayerJob(playerId, selectedValue, 1)
    if success then
        Logs.Write('INFO', string.format('Jogador %d mudou de emprego para %s.', playerId, selectedValue))
        Notifications.Send(playerId, string.format('Emprego alterado para %s com sucesso!', selectedValue), 'success')
    else
        Logs.Write('ERROR', string.format('Falha ao alterar o emprego do jogador %d.', playerId))
        Notifications.Send(playerId, 'Falha ao alterar o emprego.', 'error')
    end
end)

---Exemplo de Uso do Sistema de Banco de Dados---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database = Framework.init()

-- Exemplo: Salvar informações do jogador no banco de dados
local playerId = source -- ID do jogador
local playerInfo = module.GetPlayerInfo(playerId)

if playerInfo then
    local query = 'INSERT INTO players (identifier, name, job, money, bank) VALUES (?, ?, ?, ?, ?)'
    local parameters = { playerInfo.identifier, playerInfo.name, playerInfo.job, playerInfo.money, playerInfo.bank }

    Database.Query(query, parameters, function(result)
        if result then
            Logs.Write('INFO', string.format('Informações do jogador %d salvas no banco de dados.', playerId))
            Notifications.Send(playerId, 'Informações salvas com sucesso!', 'success')
        else
            Logs.Write('ERROR', string.format('Falha ao salvar informações do jogador %d no banco de dados.', playerId))
            Notifications.Send(playerId, 'Falha ao salvar informações.', 'error')
        end
    end)
end