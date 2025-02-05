Config = {
    Database = {
        useOxmysql = true, -- Padrão
        fallbackToSQLite = false, -- Para desenvolvimento local
        tables = {
            users = 'users',
            vehicles = 'vehicles'
        }
    }
}