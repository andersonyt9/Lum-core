local vRP = {
    getUserId = function() return '12345' end
}

-- Teste: Verifica se o identificador do jogador é retornado corretamente
function testGetPlayerIdentifier()
    local Framework = require '../core/integrations/vrp/creative_v5'
    local identifier = Framework.getPlayerIdentifier(1)
    assert(identifier == '12345', 'Falha no teste: ID do vRP não corresponde')
end

testGetPlayerIdentifier()