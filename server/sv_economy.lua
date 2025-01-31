local economy = {
    { item = 'bread', basePrice = 10, demand = 1.0 },
    { item = 'water', basePrice = 5, demand = 1.0 }
}

function GetItemPrice(item)
    for _, e in ipairs(economy) do
        if e.item == item then
            return math.floor(e.basePrice * e.demand)
        end
    end
    return 0
end

function UpdateDemand(item, multiplier)
    for _, e in ipairs(economy) do
        if e.item == item then
            e.demand = e.demand * multiplier
            break
        end
    end
end

-- Exporta as funções
exports('GetItemPrice', GetItemPrice)
exports('UpdateDemand', UpdateDemand)