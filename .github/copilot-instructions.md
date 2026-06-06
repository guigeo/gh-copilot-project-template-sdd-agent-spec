# [NOME DO PROJETO]

> [Descrição em uma linha do projeto]

---

## Contexto do Projeto

**Problema de negócio:** [Descreva o problema sendo resolvido]

**Solução:** [Descreva a solução técnica]

**Stack:** [Principais tecnologias]

**Equipe:** [Tamanho da equipe / stakeholders]

---

## Como trabalhar neste projeto

Este projeto usa o workflow **AgentSpec SDD** (Spec-Driven Development) adaptado para GitHub Copilot.
Antes de qualquer feature, use os prompts em `.github/prompts/` para guiar o processo.

### Workflow SDD — 5 fases

```
00-project-init → 01-brainstorm → 02-define → 03-design → 04-build → 05-ship
```

| Prompt | Fase | Gera |
|--------|------|------|
| `#00-project-init` | Setup | Contexto + KBs + instruções de domínio |
| `#01-brainstorm` | 0 (opcional) | `docs/sdd/features/BRAINSTORM_*.md` |
| `#02-define` | 1 | `docs/sdd/features/DEFINE_*.md` |
| `#03-design` | 2 | `docs/sdd/features/DESIGN_*.md` |
| `#04-build` | 3 | Código + `docs/sdd/features/BUILD_REPORT_*.md` |
| `#05-ship` | 4 | `docs/sdd/archive/{feature}/SHIPPED_*.md` |

### Como usar os prompts

No GitHub Copilot Chat (VS Code):
```
#file:.github/prompts/01-brainstorm.prompt.md

[descreva sua ideia aqui]
```

Ou use o comando **"Run Prompt"** no VS Code (Ctrl+Shift+P → "GitHub Copilot: Run Prompt").

### Knowledge Base

Arquivos de referência ficam em `.github/context/`. Referencie explicitamente no chat:
```
#file:.github/context/fastapi/quick-reference.md
```

---

## Estrutura do Projeto

```text
[project-root]/
├── src/           # Código-fonte
├── tests/         # Testes
├── docs/
│   └── sdd/       # Artefatos SDD (BRAINSTORM, DEFINE, DESIGN, BUILD, SHIP)
├── .github/
│   ├── copilot-instructions.md   # Este arquivo — contexto global
│   ├── prompts/                  # Prompts do workflow SDD
│   ├── instructions/             # Instruções por contexto (linguagem, domínio)
│   └── context/                  # Knowledge Base do projeto
└── ...
```

---

## Padrões de Código

### Linguagem: [ex: Python 3.11+]

- **Estilo:** [ex: Ruff / ESLint]
- **Testes:** [ex: pytest / jest]
- **Validação:** [ex: Pydantic v2 / Zod]
- **Type Hints:** obrigatórios em todas as assinaturas de função

### Convenções importantes

- [adicione convenções específicas do projeto]
- [ex: "Sempre usar dataclasses para modelos de dados"]
- [ex: "Testes devem cobrir o caminho feliz e os principais casos de erro"]

---

## Contexto de Negócio

[Preencher com /00-project-init ou manualmente]

### Entidades principais
- [entidade 1]
- [entidade 2]

### Regras de negócio
- [regra 1]
- [regra 2]

---

## Instruções de contexto disponíveis

Arquivos em `.github/instructions/` são aplicados automaticamente pelo Copilot
com base no tipo de arquivo que você está editando:

| Arquivo | Aplica quando | Conteúdo |
|---------|--------------|----------|
| `python.instructions.md` | `**/*.py` | Padrões Python do projeto |
| `tests.instructions.md` | `**/test_*.py`, `**/*.test.*` | Padrões de testes |
| `sql.instructions.md` | `**/*.sql` | Padrões SQL do projeto |
| `domain.instructions.md` | `src/**/*` | Regras de domínio do projeto |

---

## Referências

- **Prompts SDD:** `.github/prompts/`
- **Instruções de contexto:** `.github/instructions/`
- **Knowledge Base:** `.github/context/`
- **Artefatos SDD:** `docs/sdd/`
