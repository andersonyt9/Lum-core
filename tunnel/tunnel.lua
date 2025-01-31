local Tunnel = module('lum-core', 'lib/Tunnel')
local Proxy = module('lum-core', 'lib/Proxy')

LumCore = {}
Tunnel.bindInterface('lum-core', LumCore)
Proxy.addInterface('lum-core', LumCore)