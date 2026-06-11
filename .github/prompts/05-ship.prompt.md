---
description: "Fase 4 do SDD — verificar pré-ship, arquivar artefatos em archive/{FEATURE}/, capturar lições e registrar a feature em copilot-instructions.md"
mode: agent
---

# Prompt: Ship — Fase 4 do SDD

Você é o agente de **Ship**. Feche a feature: verifique, arquive os artefatos e capture lições.

**Contexto do projeto:** #file:.github/copilot-instructions.md
**Template de saída:** #file:docs/sdd/templates/SHIPPED_TEMPLATE.md
**Build report de entrada:** `#file:docs/sdd/features/BUILD_REPORT_{FEATURE}.md`

---

## Checklist pré-ship (bloqueante)

```text
[ ] BUILD_REPORT mostra 100% de conclusão
[ ] Todos os critérios de aceite do DEFINE atendidos
[ ] Testes passando
[ ] Sem issues bloqueantes / sem TODO crítico no código
```

Se algum item não estiver marcado, **não arquive** — resolva primeiro.

## Arquivar artefatos

Mova de `docs/sdd/features/` para `docs/sdd/archive/{FEATURE}/`:

- `BRAINSTORM_{FEATURE}.md` (se existir)
- `DEFINE_{FEATURE}.md`
- `DESIGN_{FEATURE}.md`
- `BUILD_REPORT_{FEATURE}.md`

## Atualizar status (status transitions)

Marque `DEFINE`, `DESIGN` e `BUILD_REPORT` como `✅ Shipped`.

---

## Gerar documento de lições aprendidas

Crie `docs/sdd/archive/{FEATURE}/SHIPPED_{YYYY-MM-DD}.md` seguindo o
[template](../../docs/sdd/templates/SHIPPED_TEMPLATE.md). Capture lições nas categorias:
**processo, técnico, comunicação, ferramentas**. Registre o que funcionou, o que melhorar,
débito técnico e impacto no projeto.

## Atualizar copilot-instructions.md

Adicione a feature na seção de features entregues:

```markdown
## Features Entregues

| Feature | Data | Descrição |
|---------|------|-----------|
| {nome} | {data} | {descrição em uma linha} |
```

> Dica: rode `#file:.github/prompts/memory.prompt.md` para destilar insights duráveis,
> e `#file:.github/prompts/contribute.prompt.md` se alguma KB/instrução criada aqui
> for reaproveitável pelo template.

---

## Início

Referencie o BUILD_REPORT e confirme que o checklist pré-ship está completo.
