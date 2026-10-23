# Adaptação ao ambiente

Confirme as ferramentas realmente presentes em cada sessão. Esta skill é um procedimento; não instala agendador, não amplia permissões e não mantém agentes em segundo plano.

## Perfis e delegação

Os perfis pessoais `fluxo-designer`, `fluxo-programador`, `fluxo-revisor` e `fluxo-qa` ficam em `<CODEX_HOME>/agents/*.toml`. O instalador usa `~/.codex` quando CODEX_HOME não está definido. Suas instruções apontam para os arquivos canônicos desta skill; não mantenha uma segunda cópia de regras por papel.

- Se a ferramenta de criação expuser seleção de tipo/perfil, selecione o perfil instalado e envie a ordem delimitada.
- Se expuser somente nome e mensagem (por exemplo, `collaboration.spawn_agent`), forneça o caminho absoluto de `references/<papel>.md` e peça ao especialista para lê-lo. O nome da tarefa não aplica automaticamente o TOML.
- Quando possível, use contexto novo (`fork_turns="none"` na interface que oferece esse parâmetro) com ordem e referências suficientes. Não envie conclusões do autor como verdade ao Revisor.
- Especialistas não precisam carregar toda a skill nem coordenar novos agentes. O Chefe conserva as decisões e aprovações.
- Use a ferramenta de continuação do mesmo subagente para correções; se ele não existir mais, recupere o registro antes de recriá-lo.
- Respeite o limite de concorrência informado pelo ambiente. Faça etapas dependentes em sequência; não configure limites globais ou modelos por conta própria.

## Permissões reais

Subagentes herdam permissões da sessão principal. Instruir o Revisor a não editar é uma restrição de comportamento; não equivale a um sandbox de leitura. Use isolamento de leitura somente se o ambiente efetivamente o suportar e confirme a configuração. Não declare isolamento que não foi aplicado.

Não use um perfil para ampliar acesso a arquivos, credenciais, rede ou conectores. Ferramentas externas continuam sujeitas às suas autorizações. A disponibilidade de uma ferramenta não significa autorização para realizar qualquer operação.

## Instalação e atualização

SKILL.md, referências e modelos devem permanecer juntos. Mudança no diretório pessoal exige atualizar os caminhos dos TOMLs. Evite cópias com o mesmo nome em escopo pessoal e de projeto. A descoberta de skills e perfis deve ser verificada pelo cliente, além da validação de YAML/TOML. Se o cliente não refletir novos arquivos, abra uma nova sessão ou reinicie-o; isso não garante por si só que o perfil foi selecionado.

Fontes oficiais consultadas em 23/10/2026: [skills](https://learn.chatgpt.com/docs/build-skills), [subagentes e perfis](https://learn.chatgpt.com/docs/agent-configuration/subagents). Capacidades e formatos podem mudar; a versão e as ferramentas atuais prevalecem sobre exemplos históricos.
