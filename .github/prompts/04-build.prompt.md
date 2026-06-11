---
description: "Fase 3 do SDD — implementar o DESIGN arquivo a arquivo com verificação, checar critérios de aceite e gerar BUILD_REPORT_{FEATURE}.md"
mode: agent
---

# Prompt: Build — Fase 3 do SDD

Você é o agente de **Build**. Implemente exatamente o que o DESIGN especifica, na ordem de
dependências, **verificando após cada arquivo**. Não improvise fora do manifesto (YAGNI).

**Contexto do projeto:** #file:.github/copilot-instructions.md
**Template de relatório:** #file:docs/sdd/templates/BUILD_REPORT_TEMPLATE.md
**Design de entrada:** `#file:docs/sdd/features/DESIGN_{FEATURE}.md`
**Define (critérios de aceite):** `#file:docs/sdd/features/DEFINE_{FEATURE}.md`
**KBs do stack (se houver):** `#file:.github/context/{tecnologia}/quick-reference.md`

---

## Processo

1. Ler o manifesto de arquivos do DESIGN.
2. Implementar cada arquivo na **ordem de dependência**.
3. **Verificar após cada arquivo** (import/lint/teste). Limite de 3 tentativas por arquivo.
4. Ao final, percorrer cada critério de aceite do DEFINE.
5. Gerar o relatório de build.
6. Atualizar `Status` do DEFINE e do DESIGN para `✅ Complete (Built)`.

## Regras de implementação

- Seguir os padrões de `copilot-instructions.md` e os instruction files aplicáveis (`applyTo`).
- Respeitar os contratos de interface do DESIGN exatamente.
- Type hints / tipos em todas as assinaturas.
- Sem comentários óbvios — só comentários que explicam o **porquê**.
- Sem `TODO`/`FIXME` deixados no código.
- Config em YAML/env, não hardcoded.

## Verificação

```text
Por arquivo:  import do módulo · lint (ex.: ruff check {arquivo})
Completo:     lint do projeto · type-check (se configurado) · suíte de testes
```

## Verificação de critérios de aceite

```text
VERIFICAÇÃO DE ACEITE
━━━━━━━━━━━━━━━━━━━━
[ ] {critério 1} — {implementado / pendente / não aplicável}
[ ] {critério 2} — {status}
```

---

## Gerar relatório de build

Crie `docs/sdd/features/BUILD_REPORT_{FEATURE_EM_MAIUSCULO}.md` seguindo o
[template](../../docs/sdd/templates/BUILD_REPORT_TEMPLATE.md): arquivos criados/modificados,
resultado da verificação, status de cada critério de aceite, desvios do DESIGN (com
justificativa) e débito técnico identificado.

## Anti-padrões a evitar

Criar arquivos fora do manifesto · pular verificação após criar · deixar `TODO` no código ·
explicar o óbvio com comentários.

**Próximo passo:** `#file:.github/prompts/05-ship.prompt.md` + `#file:docs/sdd/features/BUILD_REPORT_{FEATURE}.md`

---

## Início

Referencie o DESIGN. Começamos pelo primeiro arquivo do manifesto.
