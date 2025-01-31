fx_version 'cerulean'
game 'gta5'

author 'andersonyt99'
description 'Lum Core - Uma framework universal para FiveM'
version '1.0.0'

client_scripts {
    'client/cl_main.lua',
    'client/modules/*.lua',
    'client/lib/*.lua',
    'ui/ui.lua'
}

server_scripts {
    'server/sv_main.lua',
    'server/modules/*.lua',
    'server/lib/*.lua'
}

shared_scripts {
    'shared/config.lua',
    'shared/modules/*.lua',
    'shared/lib/*.lua',
    'tunnel/tunnel.lua'
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/style.css',
    'ui/script.js'
}