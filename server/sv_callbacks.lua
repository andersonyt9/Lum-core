local callbacks = {}

RegisterServerEvent('lum-core:triggerCallback')
AddEventHandler('lum-core:triggerCallback', function(name, ...)
    local src = source
    if callbacks[name] then
        callbacks[name](src, function(...)
            TriggerClientEvent('lum-core:callback', src, ...)
        end, ...)
    end
end)

function RegisterCallback(name, cb)
    callbacks[name] = cb
end

-- Exporta a função
exports('RegisterCallback', RegisterCallback)