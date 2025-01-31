local Auction = {}

-- Tabela para armazenar os leilões
local auctions = {}

-- Função para criar um leilão
function Auction.CreateAuction(playerId, item, amount, startingBid)
    local auctionId = #auctions + 1
    auctions[auctionId] = {
        id = auctionId,
        seller = playerId,
        item = item,
        amount = amount,
        startingBid = startingBid,
        currentBid = startingBid,
        highestBidder = nil,
        active = true
    }
    Logs.Write('INFO', string.format('Jogador %d criou um leilão para %d %s.', playerId, amount, item))
    Notifications.Send(playerId, 'Leilão criado com sucesso!', 'success')
    return auctionId
end

-- Função para dar lance em um leilão
function Auction.PlaceBid(playerId, auctionId, bidAmount)
    local auction = auctions[auctionId]
    if auction and auction.active then
        if bidAmount > auction.currentBid then
            auction.currentBid = bidAmount
            auction.highestBidder = playerId
            Logs.Write('INFO', string.format('Jogador %d deu um lance de %d no leilão %d.', playerId, bidAmount, auctionId))
            Notifications.Send(playerId, 'Lance realizado com sucesso!', 'success')
        else
            Logs.Write('WARNING', string.format('Jogador %d tentou dar um lance menor que o atual no leilão %d.', playerId, auctionId))
            Notifications.Send(playerId, 'Seu lance deve ser maior que o lance atual.', 'error')
        end
    else
        Logs.Write('ERROR', string.format('Leilão %d não encontrado ou inativo.', auctionId))
    end
end

-- Função para finalizar um leilão
function Auction.EndAuction(auctionId)
    local auction = auctions[auctionId]
    if auction and auction.active then
        auction.active = false
        if auction.highestBidder then
            -- Transfere o dinheiro para o vendedor
            Economy.AddMoney(auction.seller, auction.currentBid)
            -- Transfere o item para o comprador
            Inventory.AddItem(auction.highestBidder, auction.item, auction.amount)
            Logs.Write('INFO', string.format('Leilão %d finalizado. Jogador %d comprou %d %s por %d.', auctionId, auction.highestBidder, auction.amount, auction.item, auction.currentBid))
            Notifications.Send(auction.seller, string.format('Leilão finalizado! Você recebeu %d pelo item.', auction.currentBid), 'success')
            Notifications.Send(auction.highestBidder, string.format('Leilão finalizado! Você comprou %d %s.', auction.amount, auction.item), 'success')
        else
            Logs.Write('INFO', string.format('Leilão %d finalizado sem lances.', auctionId))
            Notifications.Send(auction.seller, 'Leilão finalizado sem lances.', 'info')
        end
    else
        Logs.Write('ERROR', string.format('Leilão %d não encontrado ou inativo.', auctionId))
    end
end

-- Retorna a interface de leilões
return Auction