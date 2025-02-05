function StartProfiler()
    if Config.Debug.enableProfiler then
        StartProfiling('LumCore')
    end
end

function StopProfiler()
    if Config.Debug.enableProfiler then
        StopProfiling('LumCore')
        local data = GetProfilingData('LumCore')
        exports['lum-core']:LogWebhook('performance', json.encode(data))
    end
end