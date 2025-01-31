# Lum-core

Um framework modular para FiveM que suporta ESX, vRP, QBCore e frameworks personalizadas.

## Funcionalidades

- **Sistema de Economia:** Gerencia dinheiro e transações bancárias.
- **Sistema de Inventário:** Gerencia itens e trocas entre jogadores.
- **Sistema de Propriedades:** Permite comprar, vender e gerenciar propriedades.
- **Sistema de Veículos:** Gerencia veículos personalizados.
- **Sistema de Logs:** Registra ações importantes e envia logs para webhooks.
- **Interface de Configuração:** Permite configurar o framework via comandos ou interface gráfica.
- **Sistema de Plugins:** Adiciona funcionalidades extras sem modificar o núcleo.

## Como Usar

1. **Instalação:**
   - Adicione o recurso `Lum-core` à sua pasta `resources`.
   - Adicione `ensure Lum-core` ao seu arquivo `server.cfg`.

2. **Configuração:**
   - Edite o arquivo `config.json` para definir as configurações iniciais.
   - Use o comando `/configui` para abrir a interface gráfica de configuração.

3. **Plugins:**
   - Adicione plugins na pasta `plugins/`.
   - Cada plugin deve ter um arquivo `plugin.lua` e um `config.json`.

## Comandos

- `/config set <chave> <valor>`: Define um valor na configuração.
- `/config get <chave>`: Exibe o valor de uma chave na configuração.
- `/config save`: Salva as alterações no arquivo de configuração.
- `/config reload`: Recarrega o arquivo de configuração.
- `/configui`: Abre a interface gráfica de configuração.

## Licença

Este projeto está licenciado sob a licença LUM. Veja o arquivo `LICENSE` para mais detalhes.