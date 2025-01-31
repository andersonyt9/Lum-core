local events = {
    { type = 'robbery', label = 'Roubo em andamento', coords = vector3(-1275.6, -1366.9, 4.3) },
    { type = 'chase', label = 'Perseguição policial', coords = vector3(0.0, 0.0, 0.0) }
}

local activeEvents = {}

function StartEvent(eventType)
    local event = nil
    for _, e in ipairs(events) do
        if e.type == eventType then
            event = e
            break
        end
    end

    if not event then return false, "Evento inválido." end

    table.insert(activeEvents, event)
    TriggerClientEvent('lum-core:startEvent', -1, event)
    return true, string.format('Evento iniciado: %s', event.label)
end

function EndEvent(eventType)
    for i, event in ipairs(activeEvents) do
        if event.type == eventType then
            table.remove(activeEvents, i)
            TriggerClientEvent('lum-core:endEvent', -1, event)
            return true, string.format('Evento finalizado: %s', event.label)
        end
    end
    return false, "Evento não encontrado."
end

-- Exporta as funções
exports('StartEvent', StartEvent)
exports('EndEvent', EndEvent)