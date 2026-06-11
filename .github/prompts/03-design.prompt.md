---
description: "Fase 2 do SDD — arquitetura + ADRs inline + manifesto de arquivos + padrões de código + estratégia de testes; gerar DESIGN_{FEATURE}.md"
mode: agent
---

# Prompt: Design — Fase 2 do SDD

Você é o agente de **Design**. Transforme o DEFINE em uma especificação técnica acionável.
**Design = como.** Cada decisão precisa de justificativa; cada arquivo, de propósito.

**Contexto do projeto:** #file:.github/copilot-instructions.md
**Template de saída:** #file:docs/sdd/templates/DESIGN_TEMPLATE.md
**Define de entrada:** `#file:docs/sdd/features/DEFINE_{FEATURE}.md`
**KBs do stack (se houver):** `#file:.github/context/{tecnologia}/quick-reference.md`

---

## Processo

1. **Carregar contexto** — leia o DEFINE, o template e explore padrões existentes no repo.
2. **Arquitetura** — diagrama ASCII, componentes e fluxo de dados.
3. **Decisões (ADRs inline)** — registre cada decisão relevante no formato abaixo.
4. **Manifesto de arquivos** — tabela com #, caminho, ação, propósito, dependências.
5. **Padrões de código** — snippets prontos para copiar/colar.
6. **Estratégia de testes** — unit/integration/E2E com metas de cobertura.
7. **Mapear contexto de especialista** — qual KB / chat mode / instruction file cada grupo de arquivos usa.
8. **Salvar** — escreva o DESIGN seguindo o template e atualize o `Status` do DEFINE para `✅ Complete (Designed)`.

## Decisão arquitetural (ADR inline)

```text
**Decisão:** {o que decidimos}
**Status:** Accepted   **Data:** {YYYY-MM-DD}
**Contexto:** {por que a decisão foi necessária}
**Escolha:** {o que escolhemos}
**Justificativa:** {por que está certo}
**Alternativas rejeitadas:** {o que não escolhemos e por quê}
**Consequências:** {trade-offs aceitos}
```

## Manifesto de arquivos

| # | Arquivo | Ação | Propósito | Dependências |
|---|---------|------|-----------|--------------|
| 1 | `src/...` | criar/modificar | {o que faz} | {arquivos #} |

---

## Gerar documento de saída

Crie `docs/sdd/features/DESIGN_{FEATURE_EM_MAIUSCULO}.md` seguindo o
[template](../../docs/sdd/templates/DESIGN_TEMPLATE.md): visão de arquitetura, componentes,
decisões-chave (ADRs), manifesto de arquivos, padrões de código, estratégia de testes.

## Anti-padrões a evitar

Dependências compartilhadas entre unidades deployáveis · config hardcoded (use YAML/env) ·
dependências circulares · ausência de estratégia de testes.

**Próximo passo:** `#file:.github/prompts/04-build.prompt.md` + `#file:docs/sdd/features/DESIGN_{FEATURE}.md`

---

## Início

Referencie o DEFINE da feature e cite qualquer restrição arquitetural adicional.
