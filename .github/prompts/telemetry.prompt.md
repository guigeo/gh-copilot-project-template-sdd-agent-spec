---
description: "Gera insights de uso do AgentSpec a partir das features shipadas e dos dados de sessão (docs/telemetry/) — relatórios e recomendações. Local-only, nenhum dado sai da máquina."
mode: agent
---

# Prompt: Telemetry — insights de uso do AgentSpec

> Analisa as features shipadas e gera insights acionáveis sobre o seu uso do fluxo SDD.
> **100% local** — nenhum dado sai da máquina.

## Uso

```
#file:.github/prompts/telemetry.prompt.md  report             # relatório mais recente
#file:.github/prompts/telemetry.prompt.md  report --weekly    # relatório semanal
#file:.github/prompts/telemetry.prompt.md  report --monthly   # relatório mensal
#file:.github/prompts/telemetry.prompt.md  summary            # resumo rápido (só console)
#file:.github/prompts/telemetry.prompt.md  sessions           # lista todas as sessões
```

---

## O que faz

1. **Lê os dados de sessão** de `docs/telemetry/sessions/`
2. **Calcula agregados** (tempo por fase, efetividade dos chat modes, tendências)
3. **Gera relatórios** em `docs/telemetry/reports/`
4. **Sugere recomendações** com base nos padrões observados

---

## Tipos de relatório

| Comando | Escopo | Saída |
|---------|--------|-------|
| `report` | Tudo / últimos 30 dias — análise completa com recomendações | `REPORT_LATEST.md` |
| `report --weekly` | Semana atual + tendência semana a semana | `REPORT_YYYY-WNN.md` |
| `report --monthly` | Mês atual + tendência mês a mês | `REPORT_YYYY-MM.md` |
| `summary` | Métricas-chave num relance (só console, sem arquivo) | — |

---

## Fontes de dados

```text
docs/sdd/archive/*/            → artefatos das features shipadas
docs/telemetry/sessions/       → JSON de sessão (um por feature)
```

Os dados de sessão são capturados quando você roda o ship com a flag de telemetria
(ver `#file:.github/prompts/05-ship.prompt.md`).

---

## Local de saída

```text
docs/telemetry/
├── sessions/      # JSON bruto de sessão (um por feature)
├── reports/       # relatórios markdown gerados
└── aggregates/    # métricas calculadas (JSON)
```

---

## Exemplo de saída (`summary`)

```text
RESUMO DE TELEMETRIA AGENTSPEC
═══════════════════════════════

Features shipadas:  5
Taxa de ship:       100%
Duração média:      7,25 horas

CHAT MODES MAIS USADOS
──────────────────────
spec-driven      5 features  100% sucesso
code-reviewer    4 features  100% sucesso

RECOMENDAÇÕES
─────────────
⚠ Considere criar um chat mode de domínio para {tema recorrente}
⚠ Habilite revisão extra em features com >30 arquivos

Rode 'telemetry report' para a análise completa.
```

---

## Integração com o ship

Para capturar telemetria automaticamente ao arquivar uma feature, rode o ship sinalizando
a captura. Isso deve:

1. Arquivar a feature (comportamento normal do ship)
2. Extrair métricas dos artefatos
3. Salvar o JSON de sessão em `docs/telemetry/sessions/`
4. Atualizar os agregados

---

## Privacidade

Toda a telemetria é **local**:

- Os dados nunca saem da máquina
- Nenhuma API externa é chamada
- Você controla todos os dados
- Apague a qualquer momento: `rm -rf docs/telemetry/`

---

## Observação de adoção

> Este prompt assume a infraestrutura `docs/telemetry/` (pasta `sessions/` populada pelo ship).
> Se a captura de sessão ainda não estiver ativa no seu fluxo de ship, o `telemetry` opera só
> sobre `docs/sdd/archive/*/` (artefatos shipados) — relatórios mais simples, sem métricas de tempo.
