local Groups = {}

-- Tabela para armazenar os grupos
local groups = {}

-- Função para criar um grupo
function Groups.CreateGroup(playerId, groupName)
    local groupId = #groups + 1
    groups[groupId] = {
        id = groupId,
        name = groupName,
        leader = playerId,
        members = { playerId }
    }
    Logs.Write('INFO', string.format('Jogador %d criou o grupo %s.', playerId, groupName))
    Notifications.Send(playerId, string.format('Você criou o grupo %s.', groupName), 'success')
    return groupId
end

-- Função para adicionar um membro ao grupo
function Groups.AddMember(groupId, playerId)
    if groups[groupId] then
        table.insert(groups[groupId].members, playerId)
        Logs.Write('INFO', string.format('Jogador %d foi adicionado ao grupo %s.', playerId, groups[groupId].name))
        Notifications.Send(playerId, string.format('Você foi adicionado ao grupo %s.', groups[groupId].name), 'success')
    else
        Logs.Write('ERROR', string.format('Grupo %d não encontrado.', groupId))
    end
end

-- Função para remover um membro do grupo
function Groups.RemoveMember(groupId, playerId)
    if groups[groupId] then
        for i, memberId in ipairs(groups[groupId].members) do
            if memberId == playerId then
                table.remove(groups[groupId].members, i)
                Logs.Write('INFO', string.format('Jogador %d foi removido do grupo %s.', playerId, groups[groupId].name))
                Notifications.Send(playerId, string.format('Você foi removido do grupo %s.', groups[groupId].name), 'info')
                break
            end
        end
    else
        Logs.Write('ERROR', string.format('Grupo %d não encontrado.', groupId))
    end
end

-- Função para obter os membros de um grupo
function Groups.GetMembers(groupId)
    if groups[groupId] then
        return groups[groupId].members
    else
        return {}
    end
end

-- Retorna a interface de grupos
return Groups