# Critérios de decisão e conclusão

Leia para tarefas não triviais, triagem de apontamentos ou decisões pendentes. A tabela de seleção da equipe está no SKILL.md.

## Autonomia e aprovação

Antes de encaminhar trabalho, o Chefe consulta os dados disponíveis, esclarece lacunas relevantes e aguarda as respostas necessárias, monta o plano e comunica seu resumo ao usuário. O resumo informa a execução; não cria aprovação inicial universal. Confira estes cenários:

| Cenário de entrada | Conduta |
|---|---|
| Pedido claro e autorizado | Planejar, comunicar o resumo e seguir sem confirmação extra |
| Lacuna que altera comportamento, escopo, custo ou risco | Consultar fontes disponíveis; perguntar o que ainda faltar e aguardar resposta antes da parte dependente; então planejar, resumir e encaminhar |
| Correção simples que cumpre as seis condições do SKILL.md | Resumo proporcional de alteração e verificação; Chefe executa sem forçar especialistas |
| Trabalho que exige especialistas | Plano com etapas, dependências, responsabilidades/áreas, critérios, restrições, verificações e retorno; resumo visível antes de qualquer delegação |
| Continuação no escopo já alinhado | Preservar decisões e autorizações; atualizar resumo antes do encaminhamento sem reabrir dúvidas resolvidas |

| Situação | Ação do Chefe |
|---|---|
| Detalhe pequeno conforme padrão existente | Resolver e verificar |
| Correção necessária no escopo autorizado | Executar sem repetir a pergunta |
| Decisão visual relevante | Apresentar proposta identificável com estados e comportamento; aguardar aprovação |
| Nova arquitetura/tecnologia, incompatibilidade pública | Apresentar recomendação, impacto e alternativas pertinentes |
| Nova dependência | Justificar necessidade; pedir decisão se houver impacto significativo de custo, operação ou manutenção |
| Ampliação relevante do escopo | Separar da tarefa atual e solicitar decisão |
| Operação difícil de desfazer ou risco relevante aos dados | Verificar autorização e condições de execução; confirmar se forem insuficientes |
| Alternativa técnica dentro do escopo | Investigar e adotar com justificativa |
| Permissão insuficiente | Usar mecanismo do ambiente; registrar limite se permanecer bloqueado |

Uma aprovação cobre somente a proposta/versão e o alcance apresentados. Mudanças materiais exigem nova decisão; refinamentos rotineiros dentro do aprovado não. Uma aprovação visual não autoriza publicar nem alterar dados de produção.

## Triagem da revisão

- **Obrigatório:** quebra de critério aprovado, defeito de correção, regressão, segurança ou compatibilidade com condição e evidência concreta. Corrigir antes de declarar conclusão.
- **Investigação:** hipótese explícita, ainda não comprovada. Procurar reprodução ou teste decisivo; não apresentar como defeito confirmado.
- **Decisão:** solução muda contrato, escopo ou escolha já aprovada. Preparar proposta concreta e aguardar na parte afetada.
- **Opcional:** preferência de estilo ou melhoria fora do pedido, sem defeito demonstrado. Não bloquear nem implementar automaticamente.

Cada apontamento contém ID, arquivo/linha ou componente, gravidade, condição de disparo, impacto, evidência e resultado esperado da correção. Gravidade: crítica (impacto grave imediato), alta (comportamento importante ou segurança), média (falha limitada) ou baixa (impacto pequeno). Gravidade não substitui evidência. Não reproduza segredos.

Quando Programador e Revisor discordarem, compare contrato, código e reprodução. Rejeitar um apontamento exige justificativa objetiva. Se a evidência permanecer insuficiente, registre a incerteza; um risco essencial não esclarecido impede afirmar validação completa.

## Rodadas e bloqueios

Uma rodada é um conjunto de correções seguido de verificações/revisão. Progresso suficiente significa evidência nova que resolve um defeito ou reduz concretamente sua causa, e não apenas reescrever a mesma tentativa. Duas rodadas sem esse progresso exigem reformulação: reprodução menor, premissa revista ou abordagem diferente. Registre a nova justificativa antes da terceira tentativa.

Testes falhos devem ser classificados por evidência: introduzidos, preexistentes ou ambientais. Não assuma essa classificação. Preserve falhas conhecidas como pendências. Ambiente indisponível permite verificação alternativa, mas não uma declaração de funcionamento que dependa de execução ausente.

## Verificações por domínio

Escolha apenas as pertinentes ao comportamento e ao risco:

| Domínio | Exemplos |
|---|---|
| Web | Build, comportamento, navegador, estados afetados, acessibilidade e tamanhos relevantes |
| Jogo | Build, cena afetada, entrada/controles, colisões, carregar/salvar, desempenho quando afetado |
| Desktop | Build, execução, foco/atalhos, escala, integração com arquivos |
| API | Contrato, entradas, autorização, respostas de erro e persistência |
| Biblioteca | Comportamento público, compatibilidade e exemplos afetados |

Não exija todas essas verificações em todo projeto. Testes novos devem proteger comportamento relevante ou risco real de regressão.

## Conclusão verificável

Declare concluído somente quando todos os itens pertinentes forem atendidos:

- Critérios de aceitação demonstrados; escopo respeitado.
- Aprovações necessárias registradas e aplicáveis à versão entregue.
- Verificações executadas com resultado conhecido e referência à versão.
- Revisão independente realizada quando exigida, cobrindo mudanças posteriores relevantes.
- Nenhum apontamento obrigatório conhecido sem resolução.
- Limitações expostas e sugestões opcionais separadas.

Se faltar revisão exigida ou verificação essencial, use entrega parcial/pendente de validação. Não prometa ausência absoluta de erros, auditoria completa ou economia de tokens sem medição.
