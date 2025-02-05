local AntiCheat = {}
local lastPlayerPositions = {}

-- Detector de Godmode
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        for _, playerId in ipairs(GetPlayers()) do
            local ped = GetPlayerPed(playerId)
            local health = GetEntityHealth(ped)
            
            -- Verifica se a vida do jogador está acima do permitido
            if health > 200 then -- Exemplo: vida máxima normal é 200
                TriggerEvent('lum-core:anticheat:flag', playerId, 'godmode', 'Vida inválida: ' .. health)
            end
            
            -- Detecção de teleport (variação súbita de posição)
            local currentPos = GetEntityCoords(ped)
            if lastPlayerPositions[playerId] then
                local distance = #(currentPos - lastPlayerPositions[playerId])
                if distance > 100.0 then -- Teleport se mover mais de 100m em 10 segundos
                    TriggerEvent('lum-core:anticheat:flag', playerId, 'teleport', 'Distância: ' .. distance)
                end
            end
            lastPlayerPositions[playerId] = currentPos
        end
    end
end)

-- Ação ao detectar cheat
RegisterNetEvent('lum-core:anticheat:flag')
AddEventHandler('lum-core:anticheat:flag', function(playerId, type, evidence)
    LogWebhook('anticheat', string.format(
        "Jogador %s (%s) detectado por %s. Evidência: %s",
        GetPlayerName(playerId),
        Framework.getPlayerIdentifier(playerId),
        type,
        evidence
    ))
    
    if Config.AntiCheat.autoKick then
        DropPlayer(playerId, 'Detecção de cheat: ' .. type)
    end
end)