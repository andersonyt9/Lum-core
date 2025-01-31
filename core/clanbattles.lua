local ClanBattles = {}

-- Tabela para armazenar as batalhas
local battles = {}

-- Função para iniciar uma batalha entre clãs
function ClanBattles.StartBattle(clan1Id, clan2Id)
    local battleId = #battles + 1
    battles[battleId] = {
        id = battleId,
        clan1 = clan1Id,
        clan2 = clan2Id,
        winner = nil
    }
    Logs.Write('INFO', string.format('Batalha iniciada entre clã %d e clã %d.', clan1Id, clan2Id))
    return battleId
end

-- Função para finalizar uma batalha
function ClanBattles.EndBattle(battleId, winnerClanId)
    if battles[battleId] then
        battles[battleId].winner = winnerClanId
        Logs.Write('INFO', string.format('Batalha %d finalizada. Clã %d venceu.', battleId, winnerClanId))
        Notifications.Send(-1, string.format('Batalha entre clãs finalizada! Clã %d venceu.', winnerClanId), 'info')
    else
        Logs.Write('ERROR', string.format('Batalha %d não encontrada.', battleId))
    end
end

-- Retorna a interface de batalhas entre clãs
return ClanBattles