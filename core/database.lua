local Database = {}

-- Função para executar uma consulta no banco de dados
function Database.Query(query, parameters, callback)
    exports.oxmysql:execute(query, parameters, function(result)
        if callback then
            callback(result)
        end
    end)
end

-- Retorna a interface de banco de dados
return Database