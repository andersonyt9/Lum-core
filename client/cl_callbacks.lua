function TriggerCallback(name, cb, ...)
    TriggerServerEvent('lum-core:triggerCallback', name, ...)
    RegisterNetEvent('lum-core:callback')
    AddEventHandler('lum-core:callback', function(...)
        cb(...)
    end)
end

-- Exporta a função
exports('TriggerCallback', TriggerCallback)