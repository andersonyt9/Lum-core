local framework = nil

if GetResourceState('es_extended') == 'started' then
    framework = 'esx'
elseif GetResourceState('vrp') == 'started' then
    framework = 'vrp'
elseif GetResourceState('qb-core') == 'started' then
    framework = 'qbcore'
else
    framework = 'standalone'
end

-- Exporta a framework detectada
exports('GetFramework', function()
    return framework
end)