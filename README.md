# Copilot AgentSpec Template

> Template de projeto com o workflow **AgentSpec 4.2 (Spec-Driven Development)** adaptado para
> **GitHub Copilot + VS Code**. Crie um projeto, rode `#new-project` e comece a codar com KBs,
> chat modes e instruções selecionados pelo seu stack.

---

## O que está incluído

```text
.github/
├── copilot-instructions.md     # Contexto global (auto-carregado pelo Copilot)
├── prompts/                    # Workflow SDD + utilitários (um prompt por arquivo)
│   ├── 00-project-init · 01-brainstorm · 02-define · 03-design · 04-build · 05-ship
│   ├── iterate                 # atualização cross-phase
│   ├── new-project · contribute        # ciclo de vida template ⇄ filho
│   ├── sync-context · create-kb · memory · readme-maker · create-pr · review · dev
├── chatmodes/                  # Personas: spec-driven · code-reviewer · kb-architect
├── instructions/               # Padrões por tipo de arquivo (applyTo): python · tests · sql · domain
└── context/                    # Knowledge Base (referenciada com #file:)
    ├── pyspark · delta-lake · databricks-lakeflow
    ├── arquitetura-medalhao · qualidade-de-dados · data-mesh
    └── _templates/             # Templates para criar novas KBs
docs/
├── sdd/                        # Artefatos SDD
│   ├── features/ · archive/    # Em andamento / entregues
│   ├── templates/              # 5 templates de documento
│   ├── examples/               # Exemplo completo (GCP pipeline)
│   └── architecture/           # WORKFLOW_CONTRACTS.yaml + ARCHITECTURE.md
└── dev/                        # Dev Loop (PROMPT/PROGRESS templates)
catalog.yaml                    # Catálogo de componentes (usado por #new-project)
setup.sh                        # Fallback de criação (copia tudo)
```

---

## Requisitos

- VS Code + extensão [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
- Conta com acesso ao GitHub Copilot (Individual, Business ou Enterprise)

---

## Criar um novo projeto

### Opção A — `#new-project` (recomendado: cópia seletiva)

Abra **este repositório** no VS Code e, no Copilot Chat (modo *agent*):

```
#file:.github/prompts/new-project.prompt.md

Criar projeto "minha-api" em /Users/joao/Projetos — FastAPI + PostgreSQL, API de ingestão
```

O prompt faz a entrevista de 6 perguntas **antes** de copiar e então, via [catalog.yaml](catalog.yaml):

- Seleciona só os componentes que casam com o seu stack (um projeto Next.js não recebe instruções/KBs de Spark).
- Copia as KBs do acervo central que se aplicam; se faltar alguma, propõe criar — a KB nova fica **no template** e é reaproveitada nos próximos projetos.
- Cria o contexto de domínio do projeto (`domain.instructions.md` + `{projeto}.chatmode.md`), preenche o `copilot-instructions.md` e grava o vínculo em `.github/template-link.yaml`.

### Opção B — script de setup (fallback: copia tudo)

```powershell
# Windows (PowerShell)
.\setup.ps1 <nome-do-projeto> [diretorio-destino]
```

```bash
# Mac / Linux / Git Bash / WSL
./setup.sh <nome-do-projeto> [diretorio-destino]
```

Depois, dentro do projeto criado, rode `#file:.github/prompts/00-project-init.prompt.md` —
entrevista de 6 perguntas que preenche o `copilot-instructions.md`, sugere KBs e cria as instruções de domínio.

### Em ambos os casos, na sequência

```
#file:.github/prompts/sync-context.prompt.md     # gera a Arquitetura após adicionar código
#file:.github/prompts/01-brainstorm.prompt.md    # explore a primeira feature
```

---

## Workflow SDD — AgentSpec 4.2

```text
#01-brainstorm → #02-define → #03-design → #04-build → #05-ship      (#iterate: cross-phase)
```

| Fase | Prompt | Gera | Gate |
|------|--------|------|------|
| 0 (opcional) | `#01-brainstorm` | `BRAINSTORM_*.md` | abordagem confirmada + YAGNI |
| 1 | `#02-define` | `DEFINE_*.md` | Clarity Score ≥ 12/15 + MoSCoW |
| 2 | `#03-design` | `DESIGN_*.md` | manifesto + ADRs + testes |
| 3 | `#04-build` | código + `BUILD_REPORT_*.md` | verificação + aceite |
| 4 | `#05-ship` | `archive/{F}/SHIPPED_*.md` | checklist pré-ship |

Use o chat mode **`spec-driven`** para ser guiado fase a fase. Artefatos em `docs/sdd/`.
Contratos e quality gates: [WORKFLOW_CONTRACTS.yaml](docs/sdd/architecture/WORKFLOW_CONTRACTS.yaml).

### Como rodar um prompt

No Copilot Chat, referencie o arquivo com `#file:` (e adicione sua entrada):

```
#file:.github/prompts/02-define.prompt.md

Quero construir um sistema de notificações por e-mail
```

Ou **Ctrl+Shift+P → "Chat: Run Prompt"** e selecione o arquivo.

---

## Dev Loop (Nível 2)

Para features isoladas, utilitários e KBs — sem o overhead do SDD completo:

```
#file:.github/prompts/dev.prompt.md   "Quero construir X"      # crafta um PROMPT
#file:.github/prompts/dev.prompt.md   docs/dev/tasks/PROMPT_X.md  # executa
```

Detalhes em [docs/dev/_index.md](docs/dev/_index.md).

---

## Devolver conhecimento ao template — `#contribute`

Dentro de um projeto filho, `#file:.github/prompts/contribute.prompt.md` analisa o que foi
criado e devolve ao acervo do template **apenas o reaproveitável** (KBs de tecnologia, instruções
de papel técnico) — contexto de negócio nunca volta. Assim a biblioteca central cresce a cada projeto.

---

## Knowledge Base

KBs ficam em `.github/context/`. Para usar no chat:

```
#file:.github/context/delta-lake/quick-reference.md

Como faço upsert idempotente em Delta?
```

Criar uma nova: `#file:.github/prompts/create-kb.prompt.md` (ou o chat mode `kb-architect`).

---

## MCPs recomendados (documentação em tempo real)

- **Context7** — `https://mcp.context7.com/mcp`
- **Ref Tools** — `https://api.ref.tools/mcp`

Configure-os na sua extensão Copilot para grounding de bibliotecas durante Design/Build.

---

## Diferenças em relação ao Claude Code

| Funcionalidade | Claude Code | GitHub Copilot (este template) |
|----------------|-------------|--------------------------------|
| Criação de projeto | `/new-project` (cópia seletiva) | `#new-project` prompt (agent mode) |
| Workflow SDD | slash commands | prompt files (`#file:`) |
| Agentes por domínio | subagentes autônomos | chat modes + instruction files |
| Knowledge Base | auto-carregada | referenciada com `#file:` |
| Memória entre sessões | sistema de memória | `copilot-instructions.md` |
| Orquestração de subagentes | suportada | não suportada (chat mode orquestra) |
