function SpawnVehicle(playerId, model, coords)
    TriggerClientEvent('lum-core:spawnVehicle', playerId, model, coords)
end

-- Exporta a função
exports('SpawnVehicle', SpawnVehicle)