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

Depois, converse normalmente. O Chefe consulta os dados disponíveis e esclarece lacunas relevantes, aguardando as respostas necessárias. Em seguida, monta um plano proporcional e apresenta um resumo do entendimento, das etapas e dos responsáveis antes de qualquer delegação. Para especialistas, o plano inclui dependências, áreas de atuação, critérios, restrições, verificações e retorno esperado; anunciar apenas o uso da skill ou de um especialista não basta.

Se o pedido estiver claro, segue após o resumo sem pedir nova confirmação. Tarefas simples podem ser executadas pelo próprio Chefe; decisões visuais relevantes e mudanças maiores continuam dependendo de aprovação, e autorizações anteriores permanecem válidas dentro do seu alcance. Designer e Programador devolvem ao Chefe ordens insuficientes ou sem referência ao resumo já comunicado, antes de executar. O Chefe coordena as entregas e apresenta o resultado com verificações e pendências.

**Fluxo:** pedido → consulta dos dados → esclarecimentos e respostas, se necessários → plano e resumo visível → encaminhamento → design e aprovação, quando necessários → implementação → revisão e correções → validação e entrega.

O nome de exibição é **Maestro Dev**; a chamada da skill é **`$fluxo-desenvolvimento`**.

## Funcionamento

- O Chefe é o agente principal da conversa.
- A skill escolhe os especialistas conforme a complexidade e o risco.
- Quando a sessão não permite selecionar perfis diretamente, o Chefe delega usando as instruções de cada papel.
- Modelos e permissões seguem a sessão do Codex. O uso do fluxo não cria automações.

Para conferir a instalação: `.\instalar.ps1 -Verificar`.

## Atualizar em outro ambiente

Obtenha a versão atual do repositório e revise as diferenças com a cópia instalada. Faça backup da pasta instalada `skills/fluxo-desenvolvimento` em `CODEX_HOME` (ou `~/.codex`) e substitua seus arquivos pelo conteúdo atualizado de `skill/`, mantendo referências, modelos e `agents/openai.yaml` juntos. Reabra a conversa ou reinicie o Codex para conferir a descoberta da versão. O instalador recusa versões diferentes; executar `git pull` e `instalar.ps1` não atualiza automaticamente uma instalação existente.
