---Aqui está um exemplo de como usar o framework para obter o inventário de um jogador---

-- Carrega o framework
local Framework = require 'core/framework'
local module = Framework.init()

-- Exemplo de uso
AddEventHandler('Lum-core:getInventory', function(playerId)
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
RegisterNetEvent('Lum-core:MenuSelect')
AddEventHandler('Lum-core:MenuSelect', function(playerId, selectedValue)
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


---Exemplo de Uso do Sistema de Economia---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy = Framework.init()

-- Exemplo: Depositar dinheiro no banco
local playerId = source -- ID do jogador
local amount = 1000 -- Quantidade a depositar

local success = Economy.DepositToBank(playerId, amount)
if success then
    Logs.Write('INFO', string.format('Jogador %d depositou %d no banco.', playerId, amount))
    Notifications.Send(playerId, string.format('Depósito de %d realizado com sucesso!', amount), 'success')
else
    Logs.Write('ERROR', string.format('Falha ao depositar %d no banco do jogador %d.', amount, playerId))
    Notifications.Send(playerId, 'Falha ao realizar o depósito.', 'error')
end


---Exemplo de Uso do Sistema de Inventário---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory = Framework.init()

-- Exemplo: Adicionar um item ao inventário de um jogador
local playerId = source -- ID do jogador
local item = 'bread' -- Item a adicionar
local amount = 1 -- Quantidade a adicionar

local success = Inventory.AddItem(playerId, item, amount)
if success then
    Logs.Write('INFO', string.format('Jogador %d recebeu %d %s.', playerId, amount, item))
    Notifications.Send(playerId, string.format('Você recebeu %d %s.', amount, item), 'success')
else
    Logs.Write('ERROR', string.format('Falha ao adicionar %d %s ao inventário do jogador %d.', amount, item, playerId))
    Notifications.Send(playerId, 'Falha ao adicionar item.', 'error')
end

---Exemplo de Uso do Sistema de Missões---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions = Framework.init()

-- Exemplo: Adicionar uma missão
Missions.AddMission('coletar_pacotes', {
    title = 'Coletar Pacotes',
    description = 'Colete 5 pacotes espalhados pela cidade.',
    objectives = {
        { type = 'collect', item = 'package', amount = 5 }
    },
    reward = {
        money = 1000,
        items = {
            { item = 'bread', amount = 2 }
        }
    }
})

-- Exemplo: Iniciar uma missão para um jogador
local playerId = source -- ID do jogador
Missions.StartMission(playerId, 'coletar_pacotes')

-- Evento para completar a missão
RegisterNetEvent('Lum-core:CompleteMission')
AddEventHandler('Lum-core:CompleteMission', function(playerId, missionId)
    Missions.CompleteMission(playerId, missionId)
end)

---Exemplo de Uso do Sistema de Loja---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop = Framework.init()

-- Exemplo: Adicionar um item à loja
Shop.AddItem('bread', {
    item = 'bread',
    amount = 1,
    price = 50
})

-- Exemplo: Comprar um item
local playerId = source -- ID do jogador
Shop.BuyItem(playerId, 'bread')


---Exemplo de Uso do Sistema de Níveis---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels = Framework.init()

-- Exemplo: Adicionar experiência a um jogador
local playerId = source -- ID do jogador
Levels.AddExperience(playerId, 500)

-- Exemplo: Obter o nível e experiência de um jogador
local level, experience = Levels.GetPlayerLevel(playerId)
print(string.format('Jogador %d está no nível %d com %d de experiência.', playerId, level, experience))


---Exemplo de Uso do Sistema de Recompensas Diárias---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards = Framework.init()

-- Exemplo: Dar recompensa diária a um jogador
local playerId = source -- ID do jogador
DailyRewards.GiveDailyReward(playerId)

---Exemplo de Uso do Sistema de Amizades---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards, Friends = Framework.init()

-- Exemplo: Adicionar um amigo
local playerId = source -- ID do jogador
local friendId = 2 -- ID do amigo
Friends.AddFriend(playerId, friendId)

-- Exemplo: Remover um amigo
Friends.RemoveFriend(playerId, friendId)

-- Exemplo: Obter a lista de amigos de um jogador
local friendsList = Friends.GetFriends(playerId)
for _, friendId in ipairs(friendsList) do
    print(string.format('Jogador %d é amigo do jogador %d.', playerId, friendId))
end

---Exemplo de Uso do Sistema de Grupos---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards, Friends, Groups = Framework.init()

-- Exemplo: Criar um grupo
local playerId = source -- ID do jogador
local groupId = Groups.CreateGroup(playerId, 'Meu Grupo')

-- Exemplo: Adicionar um membro ao grupo
local memberId = 2 -- ID do membro
Groups.AddMember(groupId, memberId)

-- Exemplo: Remover um membro do grupo
Groups.RemoveMember(groupId, memberId)

-- Exemplo: Obter os membros de um grupo
local membersList = Groups.GetMembers(groupId)
for _, memberId in ipairs(membersList) do
    print(string.format('Membro %d está no grupo %d.', memberId, groupId))
end


---Exemplo de Uso do Sistema de Clãs---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards, Friends, Groups, Clans = Framework.init()

-- Exemplo: Criar um clã
local playerId = source -- ID do jogador
local clanId = Clans.CreateClan(playerId, 'Meu Clã')

-- Exemplo: Adicionar um membro ao clã
local memberId = 2 -- ID do membro
Clans.AddMember(clanId, memberId)

-- Exemplo: Remover um membro do clã
Clans.RemoveMember(clanId, memberId)

-- Exemplo: Obter os membros de um clã
local membersList = Clans.GetMembers(clanId)
for _, memberId in ipairs(membersList) do
    print(string.format('Membro %d está no clã %d.', memberId, clanId))
end

-- Exemplo: Adicionar pontos a um clã
Clans.AddPoints(clanId, 100)

---Exemplo de Uso do Sistema de Batalhas entre Clãs---

-- Carrega o framework
local Framework = require 'core/framework'
local module, Events, Logs, Permissions, Commands, Notifications, UI, Database, Economy, Inventory, Missions, Shop, Levels, DailyRewards, Friends, Groups, Clans, ClanBattles = Framework.init()

-- Exemplo: Iniciar uma batalha entre clãs
local clan1Id = 1 -- ID do primeiro clã
local clan2Id = 2 -- ID do segundo clã
local battleId = ClanBattles.StartBattle(clan1Id, clan2Id)

-- Exemplo: Finalizar uma batalha
ClanBattles.EndBattle(battleId, clan1Id)