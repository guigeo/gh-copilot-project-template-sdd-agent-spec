# Copilot AgentSpec Template

> Template de projeto com o workflow AgentSpec SDD (Spec-Driven Development) adaptado para GitHub Copilot + VS Code.

---

## O que está incluído

```
.github/
├── copilot-instructions.md     # Contexto global do projeto (auto-carregado pelo Copilot)
├── prompts/                    # Workflow SDD — um prompt por fase
│   ├── 00-project-init.prompt.md
│   ├── 01-brainstorm.prompt.md
│   ├── 02-define.prompt.md
│   ├── 03-design.prompt.md
│   ├── 04-build.prompt.md
│   ├── 05-ship.prompt.md
│   └── review.prompt.md
├── instructions/               # Instruções por contexto (aplicadas automaticamente)
│   ├── python.instructions.md  → aplicado em *.py
│   ├── tests.instructions.md   → aplicado em test_*.py
│   └── domain.instructions.md  → aplicado em src/**
└── context/                    # Knowledge Base (referenciada com #file:)
    └── _templates/
docs/
└── sdd/                        # Artefatos SDD (BRAINSTORM, DEFINE, DESIGN, BUILD, SHIP)
    ├── features/               # Features em andamento
    ├── archive/                # Features entregues
    └── templates/              # Templates de documentos
setup.sh                        # Cria novo projeto a partir deste template
```

---

## Requisitos

- VS Code
- Extensão [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
- Conta com acesso ao GitHub Copilot (Individual, Business ou Enterprise)

---

## Criar um novo projeto

```bash
./setup.sh <nome-do-projeto> [diretorio-destino]

# Exemplos:
./setup.sh minha-api
./setup.sh meu-saas /Users/joao/Projetos
```

---

## Primeiros passos após criar o projeto

```bash
# 1. Abra no VS Code
code /caminho/do/projeto

# 2. No Copilot Chat, execute o prompt de inicialização
```

No chat do Copilot:
```
#file:.github/prompts/00-project-init.prompt.md
```

O prompt vai fazer 6 perguntas e gerar:
- `copilot-instructions.md` preenchido com contexto real
- KBs em `.github/context/` para o stack declarado
- `domain.instructions.md` com entidades e regras de negócio

---

## Workflow SDD

```
#00-project-init → #01-brainstorm → #02-define → #03-design → #04-build → #05-ship
```

### Como usar cada prompt

No Copilot Chat, referencie o prompt desejado:

```
#file:.github/prompts/01-brainstorm.prompt.md

Quero construir um sistema de notificações por email
```

Ou use o comando **Run Prompt** no VS Code:
`Ctrl+Shift+P` → "GitHub Copilot: Run Prompt" → selecione o arquivo

| Fase | Como usar | Gera |
|------|-----------|------|
| **Init** | `#file:.github/prompts/00-project-init.prompt.md` | copilot-instructions.md, KBs, domain agent |
| **Brainstorm** | `#file:.github/prompts/01-brainstorm.prompt.md` + ideia | `docs/sdd/features/BRAINSTORM_*.md` |
| **Define** | `#file:.github/prompts/02-define.prompt.md` + `#file:BRAINSTORM_*.md` | `docs/sdd/features/DEFINE_*.md` |
| **Design** | `#file:.github/prompts/03-design.prompt.md` + `#file:DEFINE_*.md` | `docs/sdd/features/DESIGN_*.md` |
| **Build** | `#file:.github/prompts/04-build.prompt.md` + `#file:DESIGN_*.md` | Código + `BUILD_REPORT_*.md` |
| **Ship** | `#file:.github/prompts/05-ship.prompt.md` + `#file:BUILD_REPORT_*.md` | `docs/sdd/archive/` |

---

## Knowledge Base

KBs ficam em `.github/context/`. Para usar no chat:

```
#file:.github/context/fastapi/quick-reference.md

Como faço paginação em FastAPI?
```

Para criar uma nova KB, peça ao Copilot:
```
Gere .github/context/sqlalchemy/quick-reference.md com os padrões mais comuns
de SQLAlchemy 2.x focados em async e uso com PostgreSQL
```

---

## Instruções de contexto

Os arquivos em `.github/instructions/` são aplicados automaticamente pelo Copilot
com base nos arquivos que você está editando — sem precisar referenciar manualmente.

Para adicionar instruções de domínio específicas do seu projeto, edite:
`.github/instructions/domain.instructions.md`

---

## Diferenças em relação ao Claude Code

| Funcionalidade | Claude Code | GitHub Copilot |
|----------------|-------------|----------------|
| Inicialização do projeto | `/project-init` (automático) | Prompt `#00-project-init` (interativo) |
| Workflow SDD | Slash commands automáticos | Prompt files manuais |
| Agentes por domínio | Agentes autônomos | Instruction files por tipo de arquivo |
| Knowledge Base | Auto-carregada | Referenciada com `#file:` |
| Memória entre sessões | Sistema de memória persistente | `copilot-instructions.md` |
| Orquestração de subagentes | Suportado | Não suportado |
