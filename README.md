# Lum Core
Um núcleo multi-framework para FiveM com suporte a vRP, ESX, QBCore e QBox.

## Configuração
1. Configure o framework em `config/frameworks.lua`.
2. Adicione webhooks em `config/webhooks.lua`.
3. Importe funções do Lum Core em seus scripts:```lua
local LogWebhook = exports['lum-core']:LogWebhook
local GetPlayerLanguage = exports['lum-core']:GetPlayerLanguage