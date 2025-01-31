local Logs = {}

-- Função para registrar logs
function Logs.Write(logType, message)
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local logMessage = string.format('[%s] [%s] %s', timestamp, logType, message)
    
    -- Salva o log em um arquivo
    local logFile = 'Lum-core.log'
    local file = io.open(logFile, 'a')
    if file then
        file:write(logMessage .. '\n')
        file:close()
    else
        print('Erro ao abrir o arquivo de log.')
    end
end

-- Retorna a interface de logs
return Logs