# AgentSpec 4.2 Architecture

> Visual reference for the 5-phase development workflow with Agent Matching and Delegation

---

## System Overview

```text
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   AGENTSPEC 5-PHASE PIPELINE                                             │
├─────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                          │
│   PHASE 0              PHASE 1              PHASE 2              PHASE 3              PHASE 4           │
│   ════════             ════════             ════════             ════════             ════════          │
│   BRAINSTORM           DEFINE               DESIGN               BUILD                SHIP              │
│   (Explore)            (What + Why)         (How)                (Do)                 (Close)           │
│   [Optional]                                                                                            │
│                                                                                                          │
│   /brainstorm          /define              /design              /build               /ship             │
│        │                    │                    │                    │                    │            │
│        ▼                    ▼                    ▼                    ▼                    ▼            │
│   ┌──────────┐         ┌─────────┐          ┌─────────┐          ┌─────────┐          ┌─────────┐      │
│   │BRAINSTORM│────────▶│ DEFINE  │─────────▶│ DESIGN  │─────────▶│  BUILD  │─────────▶│  SHIP   │      │
│   │  AGENT   │ or skip │  AGENT  │          │  AGENT  │          │  AGENT  │          │  AGENT  │      │
│   │  (Opus)  │         │ (Opus)  │          │ (Opus)  │          │(Sonnet) │          │(Haiku)  │      │
│   └──────────┘         └─────────┘          └─────────┘          └─────────┘          └─────────┘      │
│        │                    │                    │                    │                    │            │
│        ▼                    ▼                    ▼                    ▼                    ▼            │
│   features/            features/            features/            reports/ +           archive/         │
│   BRAINSTORM_*.md      DEFINE_*.md          DESIGN_*.md          CODE FILES           {FEATURE}/       │
│                                                                  BUILD_REPORT_*.md    SHIPPED_*.md     │
│                                                                                                          │
├─────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                                          │
│                                      CROSS-PHASE: ITERATE                                                │
│                                      ═══════════════════                                                 │
│                                                                                                          │
│                                           /iterate                                                       │
│                                                │                                                         │
│                                                ▼                                                         │
│                                           ┌─────────┐                                                    │
│                                           │ ITERATE │                                                    │
│                                           │  AGENT  │                                                    │
│                                           │(Sonnet) │                                                    │
│                                           └─────────┘                                                    │
│                                                │                                                         │
│                              ┌─────────────────┼─────────────────┐                                       │
│                              ▼                 ▼                 ▼                                       │
│                       Updates BRAINSTORM  Updates DEFINE    Updates DESIGN                               │
│                       (with cascade)      (with cascade)    (with cascade)                               │
│                                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Phase Flow

```text
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    WORKFLOW FLOW                                         │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│   RAW IDEA                                                                               │
│   (vague request,         PHASE 0: BRAINSTORM (Optional)                                │
│    problem)          ────────────────────────▶   BRAINSTORM_{FEATURE}.md                │
│                           One Q at a time        - Discovery Q&A                         │
│                           2-3 Approaches         - Approaches Explored                   │
│                           YAGNI Ruthlessly       - Features Removed                      │
│                                                  - Selected Approach                     │
│                                  │                                                       │
│                                  ▼                                                       │
│   RAW INPUT                                                                              │
│   (notes, emails,         PHASE 1: DEFINE                                               │
│    brainstorm doc)   ────────────────────────▶   DEFINE_{FEATURE}.md                    │
│                           Extract + Validate     - Problem Statement                     │
│                           Clarity Score ≥12      - Target Users                          │
│                                                  - Success Criteria                      │
│                                                  - Acceptance Tests                      │
│                                                  - Out of Scope                          │
│                                  │                                                       │
│                                  ▼                                                       │
│                           PHASE 2: DESIGN                                               │
│   DEFINE_{FEATURE}.md ───────────────────────▶   DESIGN_{FEATURE}.md                    │
│                           Architect + Decide     - Architecture Diagram                  │
│                           No Shared Deps         - Key Decisions (inline)                │
│                                                  - File Manifest                         │
│                                                  - Code Patterns                         │
│                                                  - Testing Strategy                      │
│                                  │                                                       │
│                                  ▼                                                       │
│                           PHASE 3: BUILD                                                │
│   DESIGN_{FEATURE}.md ───────────────────────▶   CODE + BUILD_REPORT                    │
│                           Execute + Verify       - All files from manifest               │
│                           Tests Pass             - Verification results                  │
│                                                  - Issues encountered                    │
│                                  │                                                       │
│                                  ▼                                                       │
│                           PHASE 4: SHIP                                                 │
│   All Artifacts      ────────────────────────▶   archive/{FEATURE}/                     │
│                           Archive + Learn        - All artifacts moved                   │
│                                                  - SHIPPED_{DATE}.md                     │
│                                                  - Lessons learned                       │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Folder Structure (GitHub Copilot)

> No Copilot, os "comandos" são **prompt files** e os "agentes" são os próprios prompts
> (ou chat modes para personas persistentes). Não há subagentes autônomos.

```text
.github/
├── copilot-instructions.md   # Contexto global (auto-carregado)
├── prompts/                  # Workflow SDD — 1 prompt por fase
│   ├── 01-brainstorm.prompt.md   # Fase 0 (opcional)
│   ├── 02-define.prompt.md       # Fase 1
│   ├── 03-design.prompt.md       # Fase 2
│   ├── 04-build.prompt.md        # Fase 3
│   ├── 05-ship.prompt.md         # Fase 4
│   ├── iterate.prompt.md         # Cross-phase
│   └── ...                       # new-project, contribute, sync-context, etc.
├── chatmodes/                # Personas persistentes (spec-driven, code-reviewer, kb-architect)
├── instructions/             # Padrões por tipo de arquivo (applyTo)
└── context/                  # Knowledge Base referenciada com #file:

docs/
└── sdd/
    ├── _index.md             # Visão geral do workflow
    ├── features/             # BRAINSTORM + DEFINE + DESIGN ativos
    ├── archive/              # Features entregues — {FEATURE}/SHIPPED_*.md
    ├── templates/            # Templates de documento (5)
    └── architecture/         # WORKFLOW_CONTRACTS.yaml + ARCHITECTURE.md (este arquivo)
```

---

## Prompt & Mode Assignment (Copilot)

No Copilot, cada fase é um **prompt file** com frontmatter (`mode`, `model`). Não há
roteamento automático de modelo — você escolhe o modelo no chat ou via frontmatter.
Recomendação por fase (raciocínio mais forte nas fases de pensamento, execução nas demais):

| Fase | Prompt file | `mode` sugerido | Modelo recomendado |
|------|-------------|-----------------|---------------------|
| Brainstorm | `01-brainstorm.prompt.md` | `ask` (diálogo) | mais capaz (raciocínio) |
| Define | `02-define.prompt.md` | `ask` | mais capaz (raciocínio) |
| Design | `03-design.prompt.md` | `agent` | mais capaz (raciocínio) |
| Build | `04-build.prompt.md` | `agent` (edição + terminal) | rápido e preciso p/ código |
| Ship | `05-ship.prompt.md` | `agent` | rápido (tarefa simples) |
| Iterate | `iterate.prompt.md` | `agent` | médio |

> "mais capaz" = o modelo de maior raciocínio disponível na sua conta Copilot.
> O ponto não é o modelo específico, e sim casar esforço de raciocínio ao tipo de fase.

---

## Data Flow

```text
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    DATA FLOW                                             │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│   ╔═══════════════════╗                                                                 │
│   ║    RAW IDEA       ║   (Optional Phase 0)                                            │
│   ║  (Vague request)  ║                                                                 │
│   ╚═════════╤═════════╝                                                                 │
│             │                                                                            │
│             ▼                                                                            │
│   ┌───────────────────┐                                                                 │
│   │ BRAINSTORM_*.md   │─────┐                                                           │
│   │                   │     │                                                           │
│   │ - Discovery Q&A   │     │                                                           │
│   │ - Approaches      │     │ (or skip to DEFINE                                        │
│   │ - YAGNI List      │     │  with raw input)                                          │
│   │ - Selected Path   │     │                                                           │
│   └─────────┬─────────┘     │                                                           │
│             │               │                                                           │
│             ▼               ▼                                                           │
│   ┌───────────────────┐         ┌───────────────────┐                                   │
│   │ DEFINE_*.md       │────────▶│ DESIGN_*.md       │                                   │
│   │                   │         │                   │                                   │
│   │ - Problem         │         │ - Architecture    │                                   │
│   │ - Users           │         │ - Decisions       │                                   │
│   │ - Success         │         │ - File Manifest   │                                   │
│   │ - Tests           │         │ - Patterns        │                                   │
│   │ - Scope           │         │ - Testing         │                                   │
│   └───────────────────┘         └─────────┬─────────┘                                   │
│                                           │                                              │
│             ┌─────────────────────────────┴─────────────────────────────┐               │
│             │                                                           │               │
│             ▼                                                           ▼               │
│   ┌───────────────────┐                                       ┌───────────────────┐    │
│   │ CODE FILES        │                                       │ BUILD_REPORT_*.md │    │
│   │                   │                                       │                   │    │
│   │ (From manifest)   │                                       │ - Tasks completed │    │
│   │                   │                                       │ - Verification    │    │
│   │                   │                                       │ - Issues          │    │
│   └─────────┬─────────┘                                       └─────────┬─────────┘    │
│             │                                                           │               │
│             └─────────────────────────────┬─────────────────────────────┘               │
│                                           │                                              │
│                                           ▼                                              │
│                              ╔═══════════════════════╗                                  │
│                              ║  archive/{FEATURE}/   ║                                  │
│                              ║                       ║                                  │
│                              ║  - BRAINSTORM_*.md    ║                                  │
│                              ║  - DEFINE_*.md        ║                                  │
│                              ║  - DESIGN_*.md        ║                                  │
│                              ║  - BUILD_REPORT_*.md  ║                                  │
│                              ║  - SHIPPED_*.md       ║                                  │
│                              ╚═══════════════════════╝                                  │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Iteration Flow

```text
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                  ITERATION FLOW                                          │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│                         /iterate DEFINE_*.md "change"                                   │
│                                      │                                                   │
│                                      ▼                                                   │
│                              ┌──────────────┐                                            │
│                              │ DETECT PHASE │                                            │
│                              └──────┬───────┘                                            │
│                                     │                                                    │
│                    ┌────────────────┴────────────────┐                                   │
│                    ▼                                 ▼                                   │
│            ┌──────────────┐                  ┌──────────────┐                            │
│            │   DEFINE_*   │                  │   DESIGN_*   │                            │
│            │   (Phase 1)  │                  │   (Phase 2)  │                            │
│            └──────┬───────┘                  └──────┬───────┘                            │
│                   │                                 │                                    │
│                   ▼                                 ▼                                    │
│            ┌──────────────┐                  ┌──────────────┐                            │
│            │ APPLY CHANGE │                  │ APPLY CHANGE │                            │
│            │ + VERSION    │                  │ + VERSION    │                            │
│            └──────┬───────┘                  └──────┬───────┘                            │
│                   │                                 │                                    │
│                   ▼                                 ▼                                    │
│            ┌──────────────┐                  ┌──────────────┐                            │
│            │ CASCADE      │                  │ CASCADE      │                            │
│            │ CHECK        │                  │ CHECK        │                            │
│            └──────┬───────┘                  └──────┬───────┘                            │
│                   │                                 │                                    │
│          ┌───────┴────────┐                ┌───────┴────────┐                            │
│          ▼                ▼                ▼                ▼                            │
│   ┌────────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐                      │
│   │  No Impact │   │ DESIGN     │   │  No Impact │   │   CODE     │                      │
│   │            │   │ may need   │   │            │   │ may need   │                      │
│   │            │   │ update     │   │            │   │ update     │                      │
│   └────────────┘   └────────────┘   └────────────┘   └────────────┘                      │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Quality Gates

```text
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                   QUALITY GATES                                          │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│   PHASE 0: BRAINSTORM (Optional)                                                         │
│   ══════════════════════════════                                                         │
│   ┌─────────────────────────────────────────────────────────────────┐                   │
│   │ Exploration Checklist                                            │                   │
│   ├─────────────────────────────────────────────────────────────────┤                   │
│   │ [ ] Minimum 3 discovery questions asked                          │                   │
│   │ [ ] 2-3 approaches explored with trade-offs                      │                   │
│   │ [ ] YAGNI applied (features removed section not empty)           │                   │
│   │ [ ] Minimum 2 incremental validations completed                  │                   │
│   │ [ ] User confirmed selected approach                             │                   │
│   │ [ ] Draft requirements ready for /define                         │                   │
│   └─────────────────────────────────────────────────────────────────┘                   │
│                                                                                          │
│   PHASE 1: DEFINE                                                                        │
│   ═══════════════                                                                        │
│   ┌─────────────────────────────────────────────────────────────────┐                   │
│   │ Clarity Score Breakdown                         Minimum: 12/15  │                   │
│   ├─────────────────────────────────────────────────────────────────┤                   │
│   │ Problem:  [0-3] Clear, specific, actionable?                    │                   │
│   │ Users:    [0-3] Identified with pain points?                    │                   │
│   │ Goals:    [0-3] Measurable outcomes?                            │                   │
│   │ Success:  [0-3] Testable criteria?                              │                   │
│   │ Scope:    [0-3] Explicit boundaries?                            │                   │
│   └─────────────────────────────────────────────────────────────────┘                   │
│                                                                                          │
│   PHASE 2: DESIGN                                                                        │
│   ═══════════════                                                                        │
│   ┌─────────────────────────────────────────────────────────────────┐                   │
│   │ Checklist                                                        │                   │
│   ├─────────────────────────────────────────────────────────────────┤                   │
│   │ [ ] Architecture diagram present                                 │                   │
│   │ [ ] At least one decision with rationale                         │                   │
│   │ [ ] Complete file manifest                                       │                   │
│   │ [ ] Code patterns are copy-paste ready                           │                   │
│   │ [ ] Testing strategy defined                                     │                   │
│   │ [ ] No shared dependencies across units                          │                   │
│   └─────────────────────────────────────────────────────────────────┘                   │
│                                                                                          │
│   PHASE 3: BUILD                                                                         │
│   ══════════════                                                                         │
│   ┌─────────────────────────────────────────────────────────────────┐                   │
│   │ Verification                                                     │                   │
│   ├─────────────────────────────────────────────────────────────────┤                   │
│   │ [ ] All files from manifest created                              │                   │
│   │ [ ] All verification commands pass                               │                   │
│   │ [ ] Lint check passes (ruff)                                     │                   │
│   │ [ ] Tests pass (pytest)                                          │                   │
│   │ [ ] No TODO comments in code                                     │                   │
│   └─────────────────────────────────────────────────────────────────┘                   │
│                                                                                          │
│   PHASE 4: SHIP                                                                          │
│   ═════════════                                                                          │
│   ┌─────────────────────────────────────────────────────────────────┐                   │
│   │ Pre-Ship Checklist                                               │                   │
│   ├─────────────────────────────────────────────────────────────────┤                   │
│   │ [ ] BUILD_REPORT shows 100% completion                           │                   │
│   │ [ ] All tests passing                                            │                   │
│   │ [ ] No blocking issues                                           │                   │
│   │ [ ] Acceptance tests verified                                    │                   │
│   └─────────────────────────────────────────────────────────────────┘                   │
│                                                                                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Version History

| Version | Date | Changes |
| ------- | ---- | ------- |
| 4.2.0 | 2026-01-29 | Added Agent Matching (Design) + Agent Delegation (Build) |
| 4.1.0 | 2026-01-27 | Added Phase 0: Brainstorm (optional exploratory phase) |
| 4.0.0 | 2026-01-25 | Complete rewrite for 4-phase model |
