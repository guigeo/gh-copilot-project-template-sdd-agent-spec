---
description: "Dev Loop (Nível 2) — para features isoladas, utilitários e KBs sem o overhead do SDD: craftar um PROMPT, executá-lo com verificação por tarefa e retomar via PROGRESS"
mode: agent
---

# Prompt: Dev Loop — desenvolvimento agentico estruturado

Roteia entre **craftar** um PROMPT (quando você descreve algo) e **executar** um PROMPT
existente (quando aponta um arquivo). Use para trabalho de 1-4h que não exige a rastreabilidade
completa do SDD (Brainstorm→Ship).

**Templates do Dev Loop:** #file:docs/dev/templates/
**Doc completa:** #file:docs/dev/_index.md

## Roteamento

```text
"descrição em linguagem natural"  → MODO CRAFT  (faço perguntas e gero o PROMPT)
docs/dev/tasks/PROMPT_*.md        → MODO EXECUTE (executo o PROMPT tarefa a tarefa)
--list                            → listar PROMPTs em docs/dev/tasks/
--resume                          → retomar a partir do PROGRESS salvo
--dry-run                         → validar e mostrar o plano sem executar
```

## Modo Craft

1. **Explorar** o repo para contexto.
2. **Perguntar** (uma a uma) sobre escopo, qualidade, integração e como verificar.
3. **Gerar** `docs/dev/tasks/PROMPT_{NOME}.md` a partir do
   [PROMPT_TEMPLATE](../../docs/dev/templates/PROMPT_TEMPLATE.md), com tarefas priorizadas
   (🔴 arriscada / 🟡 central / 🟢 polimento) e **comando de verificação por tarefa**.
4. **Confirmar** com o usuário antes do handoff para execução.

## Modo Execute

1. **Carregar** o PROMPT + o `PROGRESS` existente (se houver).
2. **Escolher** a próxima tarefa por prioridade (🔴→🟡→🟢).
3. **Executar** a tarefa (carregando a KB/instrução/chat mode indicada).
4. **Verificar** com o comando objetivo da tarefa. Até 3 tentativas; se falhar, registrar e pausar (modo `hitl`).
5. **Atualizar** o `docs/dev/progress/PROGRESS_{NOME}.md` (ponte de memória).
6. **Repetir** até concluir ou atingir o limite (`--max`, default 30).

```text
--mode hitl  (default, pausa em decisões)   |   --mode afk (autônomo, sem pausas)
```

## Ponte de memória (recuperação de sessão)

Se a sessão for interrompida, o `PROGRESS` permite retomar com `--resume`: carrega tarefas
concluídas, pula o que já foi feito e continua da próxima incompleta, preservando decisões-chave.

## Quando usar cada nível

| Nível | Ferramenta | Tempo | Quando |
|-------|-----------|-------|--------|
| 1 — Vibe | (nenhuma) | < 30 min | correções rápidas |
| 2 — Dev Loop | este prompt | 1-4 h | feature isolada, utilitário, KB |
| 3 — SDD | `#01-brainstorm` → `#05-ship` | multi-dia | rastreabilidade, quality gates, ADRs |

## Pular o craft

Copie `docs/dev/templates/PROMPT_TEMPLATE.md` para `docs/dev/tasks/PROMPT_MINHA_TAREFA.md`,
edite e então execute apontando o arquivo.
