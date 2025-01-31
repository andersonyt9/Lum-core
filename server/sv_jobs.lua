local jobs = {
    { name = 'police', label = 'Polícia', salary = 1000 },
    { name = 'ambulance', label = 'Médico', salary = 800 },
    { name = 'mechanic', label = 'Mecânico', salary = 700 }
}

function SetPlayerJob(playerId, jobName)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.setJob(jobName, 0)
        end
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            player.Functions.SetJob(jobName, 0)
        end
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        if user then
            vRP.setUserGroup({user, jobName})
        end
    else
        -- Standalone
        TriggerClientEvent('lum-core:setJob', playerId, jobName)
    end
end

function GetPlayerJob(playerId)
    local framework = exports['lum-core']:GetFramework()
    if framework == 'esx' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            return player.job.name, player.job.grade
        end
    elseif framework == 'qbcore' then
        local player = exports['lum-core']:GetPlayerFromId(playerId)
        if player then
            return player.PlayerData.job.name, player.PlayerData.job.grade
        end
    elseif framework == 'vrp' then
        local user = exports['lum-core']:GetPlayerFromId(playerId)
        if user then
            return vRP.getUserGroup({user}), 0
        end
    else
        -- Standalone
        return 'unemployed', 0
    end
    return 'unemployed', 0
end

function PaySalary()
    for _, playerId in ipairs(GetPlayers()) do
        local jobName, _ = GetPlayerJob(playerId)
        for _, job in ipairs(jobs) do
            if job.name == jobName then
                exports['lum-core']:AddMoney(playerId, job.salary)
                TriggerClientEvent('lum-core:showNotification', playerId, string.format('Você recebeu seu salário de $%d como %s.', job.salary, job.label))
            end
        end
    end
end

-- Exporta as funções
exports('SetPlayerJob', SetPlayerJob)
exports('GetPlayerJob', GetPlayerJob)

-- Pagamento de salários a cada hora
Citizen.CreateThread(function()
    while true do
        PaySalary()
        Citizen.Wait(3600000) -- 1 hora
    end
end)