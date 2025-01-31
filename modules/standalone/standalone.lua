local Standalone = {}

-- Função para obter informações do jogador
function Standalone.GetPlayerInfo(playerId)
    -- Implementação específica para o framework Standalone
    return {
        identifier = GetPlayerIdentifier(playerId, 0),
        name = GetPlayerName(playerId),
        money = 0, -- Exemplo: Sem sistema de dinheiro integrado
        bank = 0   -- Exemplo: Sem sistema de banco integrado
    }
end

-- Função para adicionar dinheiro a um jogador
function Standalone.AddMoney(playerId, amount)
    -- Implementação específica para o framework Standalone
    -- Exemplo: Usar uma tabela local para armazenar o dinheiro
    if not Standalone.playerMoney then
        Standalone.playerMoney = {}
    end
    Standalone.playerMoney[playerId] = (Standalone.playerMoney[playerId] or 0) + amount
    return true
end

-- Função para remover dinheiro de um jogador
function Standalone.RemoveMoney(playerId, amount)
    -- Implementação específica para o framework Standalone
    if Standalone.playerMoney and Standalone.playerMoney[playerId] then
        if Standalone.playerMoney[playerId] >= amount then
            Standalone.playerMoney[playerId] = Standalone.playerMoney[playerId] - amount
            return true
        else
            return false
        end
    else
        return false
    end
end

-- Retorna as funções do módulo
return Standalone