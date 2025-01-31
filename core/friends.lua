local Friends = {}

-- Tabela para armazenar as amizades
local friendships = {}

-- Função para adicionar um amigo
function Friends.AddFriend(playerId, friendId)
    if not friendships[playerId] then
        friendships[playerId] = {}
    end
    table.insert(friendships[playerId], friendId)
    Logs.Write('INFO', string.format('Jogador %d adicionou o jogador %d como amigo.', playerId, friendId))
    Notifications.Send(playerId, string.format('Você adicionou o jogador %d como amigo.', friendId), 'success')
    Notifications.Send(friendId, string.format('O jogador %d te adicionou como amigo.', playerId), 'info')
end

-- Função para remover um amigo
function Friends.RemoveFriend(playerId, friendId)
    if friendships[playerId] then
        for i, id in ipairs(friendships[playerId]) do
            if id == friendId then
                table.remove(friendships[playerId], i)
                Logs.Write('INFO', string.format('Jogador %d removeu o jogador %d da lista de amigos.', playerId, friendId))
                Notifications.Send(playerId, string.format('Você removeu o jogador %d da lista de amigos.', friendId), 'success')
                Notifications.Send(friendId, string.format('O jogador %d te removeu da lista de amigos.', playerId), 'info')
                break
            end
        end
    end
end

-- Função para obter a lista de amigos de um jogador
function Friends.GetFriends(playerId)
    return friendships[playerId] or {}
end

-- Retorna a interface de amizades
return Friends