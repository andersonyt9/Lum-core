local Clans = {}

-- Tabela para armazenar os clãs
local clans = {}

-- Função para criar um clã
function Clans.CreateClan(playerId, clanName)
    local clanId = #clans + 1
    clans[clanId] = {
        id = clanId,
        name = clanName,
        leader = playerId,
        members = { playerId },
        points = 0
    }
    Logs.Write('INFO', string.format('Jogador %d criou o clã %s.', playerId, clanName))
    Notifications.Send(playerId, string.format('Você criou o clã %s.', clanName), 'success')
    return clanId
end

-- Função para adicionar um membro ao clã
function Clans.AddMember(clanId, playerId)
    if clans[clanId] then
        table.insert(clans[clanId].members, playerId)
        Logs.Write('INFO', string.format('Jogador %d foi adicionado ao clã %s.', playerId, clans[clanId].name))
        Notifications.Send(playerId, string.format('Você foi adicionado ao clã %s.', clans[clanId].name), 'success')
    else
        Logs.Write('ERROR', string.format('Clã %d não encontrado.', clanId))
    end
end

-- Função para remover um membro do clã
function Clans.RemoveMember(clanId, playerId)
    if clans[clanId] then
        for i, memberId in ipairs(clans[clanId].members) do
            if memberId == playerId then
                table.remove(clans[clanId].members, i)
                Logs.Write('INFO', string.format('Jogador %d foi removido do clã %s.', playerId, clans[clanId].name))
                Notifications.Send(playerId, string.format('Você foi removido do clã %s.', clans[clanId].name), 'info')
                break
            end
        end
    else
        Logs.Write('ERROR', string.format('Clã %d não encontrado.', clanId))
    end
end

-- Função para obter os membros de um clã
function Clans.GetMembers(clanId)
    if clans[clanId] then
        return clans[clanId].members
    else
        return {}
    end
end

-- Função para adicionar pontos a um clã
function Clans.AddPoints(clanId, points)
    if clans[clanId] then
        clans[clanId].points = clans[clanId].points + points
        Logs.Write('INFO', string.format('Clã %s recebeu %d pontos.', clans[clanId].name, points))
        for _, memberId in ipairs(clans[clanId].members) do
            Notifications.Send(memberId, string.format('Seu clã recebeu %d pontos!', points), 'success')
        end
    else
        Logs.Write('ERROR', string.format('Clã %d não encontrado.', clanId))
    end
end

-- Retorna a interface de clãs
return Clans