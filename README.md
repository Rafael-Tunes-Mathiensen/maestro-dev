# Maestro Dev

Uma skill para o **Codex** que coordena agentes para planejar, implementar, revisar e validar software.

Você conversa com o **Chefe**, que organiza o trabalho e aciona os especialistas conforme a necessidade: Designer, Programador, Revisor e QA opcional. Tarefas simples seguem um caminho reduzido; decisões visuais e mudanças maiores passam pela sua aprovação.

## Instalar no Windows

Requisitos: Codex com suporte a skills e subagentes, Git e PowerShell.

```powershell
git clone https://github.com/Rafael-Tunes-Mathiensen/maestro-dev.git
cd maestro-dev
.\instalar.ps1
```

A instalação adiciona a skill e quatro perfis em `~/.codex`, ou no diretório definido por `CODEX_HOME`. O instalador preserva arquivos existentes e recusa sobrescrever versões diferentes. Se a skill não aparecer, abra uma nova conversa ou reinicie o Codex.

## Usar

Abra seu projeto no Codex e peça:

```text
Use $fluxo-desenvolvimento para [descrever o que deseja criar ou corrigir].
```

Depois, converse normalmente. O Chefe entende o pedido, define o escopo, coordena os agentes e apresenta o resultado com as verificações realizadas e eventuais pendências.

**Fluxo:** pedido → planejamento → design e aprovação, quando necessários → implementação → revisão e correções → validação e entrega.

O nome de exibição é **Maestro Dev**; a chamada da skill é **`$fluxo-desenvolvimento`**.

## Funcionamento

- O Chefe é o agente principal da conversa.
- A skill escolhe os especialistas conforme a complexidade e o risco.
- Quando a sessão não permite selecionar perfis diretamente, o Chefe delega usando as instruções de cada papel.
- Modelos e permissões seguem a sessão do Codex. O uso do fluxo não cria automações.

Para conferir a instalação: `.\instalar.ps1 -Verificar`.
