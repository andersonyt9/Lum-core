MySQL.ready(function()
    LogWebhook('database', 'Conexão com o banco de dados estabelecida.')
end)

function DatabaseQuery(query, params)
    return MySQL.query.await(query, params)
end

function GetPlayerData(playerId)
    local cached = GetCachedPlayer(playerId)
    return MySQL.single.await('SELECT * FROM users WHERE identifier = ?', { cached.identifier })
end

MySQL = require '@oxmysql/lib/init'

-- Configuração do pool
MySQL.setupPool({
    connectionLimit = 10,
    queueTimeout = 5000
})

-- Query com pool
function MySQL.queryPool(query, params)
    return MySQL.rawExecute(query, params)
end