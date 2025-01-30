local Events = {}

-- Registra um evento genérico
function Events.Register(eventName, callback)
    AddEventHandler(eventName, callback)
end

-- Dispara um evento genérico
function Events.Trigger(eventName, ...)
    TriggerEvent(eventName, ...)
end

-- Retorna a interface de eventos
return Events