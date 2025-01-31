fx_version 'cerulean'
game 'gta5'

author 'andersonyt99'
description 'Lum Core - Um framework universal para FiveM'
version '1.0.0'

client_scripts {
    'client/cl_utils.lua',
    'client/cl_framework_detection.lua',
    'client/cl_main.lua',
    'client/cl_ui.lua'
}

server_scripts {
    'server/sv_framework_detection.lua',
    'server/sv_main.lua',
    'server/sv_logs.lua',
    'server/sv_config.lua'
}

shared_scripts {
    'config/config.lua'
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/ui.css',
    'ui/ui.js'
}