---
description: "Roda NO TEMPLATE — adota um projeto JÁ EXISTENTE (brownfield): detecta o stack a partir do código, entende o projeto, instala a estrutura .github/ de forma ADITIVA (sem sobrescrever nada) e grava o vínculo. Read-only no template — nunca escreve no acervo."
mode: agent
---

# Prompt: Adopt (brownfield) — adotar projeto existente

> Roda **no repositório do template** (bootstrap: o projeto legado ainda não tem `.github/`
> do AgentSpec, logo não tem este prompt). Aponta para um projeto que **já existe** e o
> transforma em filho.
>
> **Irmão do `new-project`:** reusa o mesmo motor de seleção via `catalog.yaml`, mas em vez de
> criar uma pasta nova e vazia, ele **detecta o stack do código existente**, copia de forma
> **aditiva e não-destrutiva**, e preenche o `copilot-instructions.md` **analisando o código real**.
>
> **TRAVA DE SEGURANÇA — read-only no template:** o adopt NUNCA escreve no acervo central.
> KB que falte vira **stub local no filho** (ou só uma anotação). O conhecimento do legado só
> volta ao template pela porta guardada `distill` → `contribute` (leak-check), nunca aqui.

**Catálogo (fonte da verdade):** `#file:catalog.yaml`

## Uso

```
#file:.github/prompts/adopt.prompt.md

Adotar /Users/joao/Projetos/projeto-legado — é uma API FastAPI de cobrança
```

---

## Processo

### 1. Validar ambiente

```text
Ler catalog.yaml                       # Obrigatório — se não existir, não é o template. Abortar.
git rev-parse HEAD                      # SHA do template → gravado no filho

# O DESTINO é um projeto existente:
test -d {destino}                       # tem que existir
ls -A {destino}                         # tem que ter conteúdo (código) — se vazio, use new-project
git -C {destino} rev-parse HEAD         # ideal ter git; se não tiver, avisar (sem bloquear)
```

Se o destino não existir ou estiver vazio: **abortar** e sugerir `new-project` (greenfield).

### 2. Detectar o stack a partir do código (read-only)

Ler os arquivos-chave do projeto para **inferir** stack/domínio/cloud (não entrevistar do zero):

```text
Linguagem/deps: pyproject.toml, requirements*.txt, package.json, go.mod, Cargo.toml, pom.xml
Frameworks:     imports e deps (fastapi, flask, django, react, next, spark, pandas...)
Cloud/infra:    *.tf, serverless.yml, Dockerfile, .github/workflows, sam template, databricks.yml
Domínio:        estrutura de pastas + entrypoints (api/ routes/ → api-web; notebooks/ dags/ → data-pipeline; cli/ → cli)
```

Montar uma proposta **normalizada para a taxonomia do `catalog.yaml`** (stacks kebab-case;
domínio e cloud canônicos) e **apresentar para o usuário confirmar/ajustar** — a detecção
pode errar; nunca seguir sem confirmação. Se o usuário passou descrição como argumento, usar
para desambiguar.

### 3. Entender o projeto (relatório de entendimento)

Produzir um entendimento do projeto. **Regra de custo:** projeto **pequeno** (poucos arquivos)
→ ler o código inline (mais rápido); projeto **grande/desconhecido** → explorar em profundidade
(o Copilot não tem agente explorador separado; faça a varredura você mesmo, módulo a módulo,
priorizando entrypoints, configs e os módulos centrais).

Consolidar num **RELATÓRIO DE ENTENDIMENTO** com Executive Summary + Deep Dive (arquitetura,
módulos principais, padrões, dependências, dívidas/pontos fracos) e uma seção
**"Oportunidades de melhoria (candidatos)"** — uma LISTA, não um plano priorizado. A priorização
e a reconstrução são tocadas depois pelo usuário via `01-brainstorm` → `02-define` (cada candidato
vira semente). Este relatório será gravado no filho no Passo 8.

### 4. Seleção de componentes via catálogo

Aplicar as MESMAS regras do `new-project` Passo 3 (ver `#file:catalog.yaml`):

```text
scope: core          → SEMPRE copiar
scope: template-only → NUNCA copiar (este prompt, new-project)
scope: optional      → só se TODAS as dimensões declaradas casarem (AND entre dimensões,
                       não OR achatado) com o stack/domínio/cloud detectados no Passo 2
```

**KBs (context):** comparar stack detectado com a seção `context:` do catálogo:

```text
KB existe no acervo  → entra na lista "copiar"
KB NÃO existe        → vira STUB LOCAL no filho (ou anotação) — NUNCA criar no acervo central
```

### 5. Confirmar o plano

```text
PLANO DE ADOÇÃO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Projeto existente:  {destino}   (git: {sim/não})
Stack detectado:    {stacks} | Domínio: {dominio} | Cloud: {cloud}   (confirmado pelo usuário)

Já existe .github/ no projeto? {sim/não}
  → se sim: a cópia é por arquivo, merge cuidadoso, PERGUNTA em cada conflito

Prompts/instructions/chatmodes a copiar ({n}):
  core: {lista} | optional: {lista c/ motivo} | excluídos: {motivos}
KBs do acervo (context) a copiar ({n}): {lista}
KBs faltantes (stub local no filho, NÃO no acervo): {lista}
Chat mode/instruction de domínio a criar NO FILHO: {projeto}.chatmode.md + domain.instructions.md

Relatório de entendimento → docs/UNDERSTANDING_{projeto}.md
Commit: NÃO (você revisa o diff)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confirmar? (sim / ajustar)
```

### 6. Cópia ADITIVA e não-destrutiva

Copiar a seleção para o destino existente, **sem nunca sobrescrever artefato do projeto**:

```text
COPIAR (igual new-project, mas ADITIVO):
  .github/prompts/ (exceto new-project.prompt.md e adopt.prompt.md)
  .github/chatmodes/{selecionados}  | .github/instructions/{selecionados}
  .github/context/_templates/  | .github/context/{KBs selecionadas}
  docs/sdd/  | docs/dev/
  .github/context/_index.yaml → conter APENAS as KBs copiadas

REGRAS DE NÃO-DESTRUIÇÃO:
  • Arquivo do projeto que JÁ existe (código, README, .gitignore, configs) → NUNCA tocar
  • Se já existe .github/{arquivo} → comparar; conflito real → PERGUNTAR (manter / mesclar / pular)
  • copilot-instructions.md já existe no projeto → NÃO sobrescrever (tratar no Passo 8 por anexação)
  • .gitignore já existe → acrescentar entradas faltantes, não substituir

NÃO COPIAR: catalog.yaml, setup.sh, setup.ps1, README.md (do template),
            new-project.prompt.md, adopt.prompt.md, .DS_Store
```

### 7. Criar chat mode/instruction de domínio no filho

Igual `new-project` Passo 7 / `00-project-init` Passo 6: criar em `{destino}/.github/chatmodes/`
o `{projeto}.chatmode.md` e em `{destino}/.github/instructions/domain.instructions.md` as regras
de negócio. O contexto de negócio (derivado do código + do que o usuário informou) vai para esses
arquivos — **nunca** para o acervo. Sem `{placeholder}`.

### 8. copilot-instructions.md, vínculo e relatório

```text
1. copilot-instructions.md:
   - NÃO existe no projeto → criar preenchido com o que foi DETECTADO/ANALISADO no código
     (não inventar) + domínio/restrições confirmados
   - JÁ existe → preservar; ANEXAR uma seção "## AgentSpec / SDD" apontando para os prompts,
     chat modes e KBs instalados (sem reescrever o conteúdo do usuário)

2. Gravar o relatório do Passo 3 em: {destino}/docs/UNDERSTANDING_{projeto}.md

3. Criar {destino}/.github/template-link.yaml:
     template_path: {caminho absoluto deste repositório}
     template_version: {SHA do Passo 1}
     catalog_version: {version do catalog.yaml}
     created_at: "{hoje}"
     created_via: adopt
     selection: { stacks, domains, clouds }
     components: { prompts: [...], chatmodes: [...], instructions: [...], context: [...] }
```

### 9. SEM commit + relatório final

**Não commitar** — o projeto já tem história; o usuário revisa o diff antes.
**Não escrever nada no template** (read-only): nenhuma KB no acervo, nenhum commit no template.

```text
PROJETO ADOTADO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Projeto: {destino}  (NÃO commitado — revise o diff: git -C {destino} status)
✓ Stack: {stacks} | Domínio: {dominio} | Cloud: {cloud}
✓ Prompts copiados: {n}  |  KBs copiadas: {n}  |  KBs stub local: {n}
✓ Domínio criado: {projeto}.chatmode.md + domain.instructions.md
✓ copilot-instructions.md: {criado | seção anexada}  |  template-link.yaml gravado ({SHA curto})
✓ Entendimento: docs/UNDERSTANDING_{projeto}.md ({n} oportunidades de melhoria listadas)
✓ Template: inalterado (read-only)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PRÓXIMOS PASSOS (no projeto adotado):
  1. Revisar o diff e commitar quando estiver satisfeito
  2. Ler docs/UNDERSTANDING_{projeto}.md
  3. Escolher uma oportunidade de melhoria → 01-brainstorm "..." (ela é a semente)
  4. 02-define → 03-design → 04-build → 05-ship
  5. Conhecimento genérico volta ao template via distill → contribute
```

---

## Gate de qualidade

```text
[ ] catalog.yaml lido e SHA do template capturado
[ ] Destino validado: existe E tem conteúdo (senão → new-project)
[ ] Stack detectado do código e CONFIRMADO pelo usuário (detecção pode errar)
[ ] Relatório de entendimento gerado (com seção de oportunidades — lista, não plano priorizado)
[ ] Seleção via catálogo com regra AND entre dimensões; exclusões com motivo
[ ] KBs faltantes viraram stub local — NENHUMA escrita no acervo do template
[ ] Cópia ADITIVA: nenhum arquivo do projeto sobrescrito; conflitos em .github/ perguntados
[ ] copilot-instructions.md: criado (se não havia) ou seção anexada (se havia) — sem destruir conteúdo
[ ] Domínio sem {placeholder}; negócio só no filho (chatmode + domain.instructions)
[ ] template-link.yaml gravado (created_via: adopt)
[ ] UNDERSTANDING_{projeto}.md gravado em docs/
[ ] NENHUM commit (nem no filho, nem no template); template inalterado
[ ] Relatório final exibido
```

---

## Casos especiais

| Situação | Ação |
|----------|------|
| Rodado fora do template (sem catalog.yaml) | Abortar — o adopt vive só no template |
| Destino não existe ou está vazio | Abortar — use `new-project` (greenfield) |
| Destino já tem `.github/` completo (já é filho) | Avisar — provavelmente quer atualizar o template, não adotar |
| Conflito de arquivo em `.github/` | Perguntar: manter o do projeto / mesclar / pular |
| Stack não detectável com confiança | Perguntar ao usuário (cai no modo entrevista do new-project) |
| Projeto sem git | Avisar (diff manual), seguir sem bloquear |
| KB faltante para o stack | Stub local no filho — NUNCA criar no acervo central |

---

## Referências

- Irmão greenfield: `#file:.github/prompts/new-project.prompt.md`
- Entrevista e templates de domínio: `#file:.github/prompts/00-project-init.prompt.md`
- Catálogo e regra de seleção: `#file:catalog.yaml`
- Porta de volta ao acervo: `#file:.github/prompts/distill.prompt.md` → `#file:.github/prompts/contribute.prompt.md`
