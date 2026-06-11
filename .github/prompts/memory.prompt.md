---
description: "Destila insights duráveis da sessão e os grava em copilot-instructions.md (decisões, convenções, gotchas) — sem ruído de conversa nem segredos"
mode: agent
---

# Prompt: Memory — registrar insights duráveis

Capture o que vale lembrar entre sessões e grave em `#file:.github/copilot-instructions.md`.
O Copilot carrega esse arquivo automaticamente, então ele é a "memória" do projeto.

## O que gravar (e o que não)

| Gravar | Não gravar |
|--------|------------|
| Decisões de arquitetura e o **porquê** | Detalhe já óbvio no código |
| Convenções acordadas com a equipe | Histórico do git (já versionado) |
| Gotchas / armadilhas descobertas | Conversa efêmera da sessão |
| Restrições externas (cotas, SLAs, prazos absolutos) | Segredos, tokens, credenciais |

Converta datas relativas em absolutas ("hoje" → `2026-06-11`).

## Processo

1. Revisar a sessão e propor uma lista curta de candidatos (1 linha cada).
2. Para cada um, classificar: **decisão / convenção / gotcha / restrição**.
3. Conferir se já existe registro equivalente no `copilot-instructions.md` — **atualizar** em vez de duplicar.
4. Após confirmação, escrever na seção apropriada (ex.: "Convenções importantes", "Contexto de Negócio", "Features Entregues").
5. Mostrar o diff do que foi adicionado/atualizado.

## Saída

```text
MEMORY
━━━━━━
+ Convenção: {...}
~ Atualizado: {...}
- Descartado (efêmero/óbvio): {n}
```
