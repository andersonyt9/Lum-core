local Trade = {}

-- Tabela para armazenar as propostas de comércio
local tradeOffers = {}

-- Função para criar uma proposta de comércio
function Trade.CreateOffer(playerId, targetId, offerItems, requestItems)
    local tradeId = #tradeOffers + 1
    tradeOffers[tradeId] = {
        id = tradeId,
        player1 = playerId,
        player2 = targetId,
        offerItems = offerItems,
        requestItems = requestItems,
        accepted = false
    }
    Logs.Write('INFO', string.format('Jogador %d criou uma proposta de comércio para o jogador %d.', playerId, targetId))
    Notifications.Send(playerId, 'Proposta de comércio enviada.', 'success')
    Notifications.Send(targetId, 'Você recebeu uma proposta de comércio.', 'info')
    return tradeId
end

-- Função para aceitar uma proposta de comércio
function Trade.AcceptOffer(tradeId)
    local trade = tradeOffers[tradeId]
    if trade and not trade.accepted then
        trade.accepted = true

        -- Verifica se os jogadores têm os itens oferecidos
        local player1HasItems = true
        for _, itemData in ipairs(trade.offerItems) do
            if not Inventory.HasItem(trade.player1, itemData.item, itemData.amount) then
                player1HasItems = false
                break
            end
        end

        local player2HasItems = true
        for _, itemData in ipairs(trade.requestItems) do
            if not Inventory.HasItem(trade.player2, itemData.item, itemData.amount) then
                player2HasItems = false
                break
            end
        end

        if player1HasItems and player2HasItems then
            -- Remove os itens dos jogadores
            for _, itemData in ipairs(trade.offerItems) do
                Inventory.RemoveItem(trade.player1, itemData.item, itemData.amount)
            end
            for _, itemData in ipairs(trade.requestItems) do
                Inventory.RemoveItem(trade.player2, itemData.item, itemData.amount)
            end

            -- Adiciona os itens aos jogadores
            for _, itemData in ipairs(trade.requestItems) do
                Inventory.AddItem(trade.player1, itemData.item, itemData.amount)
            end
            for _, itemData in ipairs(trade.offerItems) do
                Inventory.AddItem(trade.player2, itemData.item, itemData.amount)
            end

            Logs.Write('INFO', string.format('Comércio %d foi aceito e concluído com sucesso.', tradeId))
            Notifications.Send(trade.player1, 'Comércio concluído com sucesso!', 'success')
            Notifications.Send(trade.player2, 'Comércio concluído com sucesso!', 'success')
        else
            Logs.Write('WARNING', string.format('Comércio %d não pôde ser concluído devido à falta de itens.', tradeId))
            Notifications.Send(trade.player1, 'Comércio não pôde ser concluído. Verifique seus itens.', 'error')
            Notifications.Send(trade.player2, 'Comércio não pôde ser concluído. Verifique seus itens.', 'error')
        end
    else
        Logs.Write('ERROR', string.format('Comércio %d não encontrado ou já foi aceito.', tradeId))
    end
end

-- Função para recusar uma proposta de comércio
function Trade.DeclineOffer(tradeId)
    local trade = tradeOffers[tradeId]
    if trade and not trade.accepted then
        tradeOffers[tradeId] = nil
        Logs.Write('INFO', string.format('Comércio %d foi recusado.', tradeId))
        Notifications.Send(trade.player1, 'Proposta de comércio recusada.', 'info')
        Notifications.Send(trade.player2, 'Proposta de comércio recusada.', 'info')
    else
        Logs.Write('ERROR', string.format('Comércio %d não encontrado ou já foi aceito.', tradeId))
    end
end

-- Retorna a interface de comércio
return Trade