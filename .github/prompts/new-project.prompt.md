---
description: "Roda NO TEMPLATE — entrevista, seleciona componentes via catalog.yaml por stack/domínio/cloud, cria KBs faltantes no acervo e copia seletivamente para um projeto filho"
mode: agent
---

# Prompt: New Project — cópia seletiva a partir do template

> Roda **no repositório do template**. Substitui o `setup.sh` (que copia tudo) por:
> entrevista → seleção via catálogo → criação de lacunas no acervo → cópia seletiva.
>
> Conhecimento reaproveitável (KBs de tecnologia, instruções de papel técnico) nasce e fica
> **no template**. Conhecimento específico (regras de negócio, domínio do projeto) nasce **no filho**.
>
> **Greenfield (pasta nova e vazia).** Para adotar um projeto que **já existe** (brownfield),
> use o irmão `#file:.github/prompts/adopt.prompt.md`.

**Catálogo (fonte da verdade):** #file:catalog.yaml

## Uso

```
#file:.github/prompts/new-project.prompt.md

Criar projeto "minha-api" em /Users/joao/Projetos — FastAPI + PostgreSQL, API de ingestão
```

---

## Processo

### 1. Validar ambiente
- Ler `catalog.yaml`. Se não existir, **abortar**: "Isto não é o template — rode dentro do template".
- Capturar o SHA atual (`git rev-parse HEAD`) — será gravado no filho.
- Pedir nome e diretório de destino se não fornecidos. Se o destino existir e não estiver vazio: **abortar** (nunca sobrescrever).

### 2. Entrevista (uma pergunta por vez)
Mesmas 6 perguntas do `#file:.github/prompts/00-project-init.prompt.md` (P1–P6):
identidade, stack, domínio, cloud, equipe/restrições, contexto adicional (PRD — opcional).
Normalize as respostas para a taxonomia do catálogo (stacks em kebab-case; domínio e cloud nos valores canônicos do cabeçalho do `catalog.yaml`).

### 3. Seleção via catálogo
Para cada entrada do `catalog.yaml`:

```text
scope: core          → SEMPRE copiar
scope: template-only → NUNCA copiar (ex.: este prompt new-project, adopt)
scope: optional      → copiar SÓ se TODAS as dimensões que o componente DECLARA casarem
                       (AND entre dimensões, não OR achatado): para cada dimensão presente
                       (stacks / domains / clouds) tem que haver interseção com as respostas
                       P2–P4; dimensão ausente = curinga. Ex.: clouds:[aws]+stacks:[python]
                       NÃO entra em cloud=local só porque "python" casou.
```

**KBs (`.github/context/`):** comparar o stack com a seção `context:` do catálogo:
- KB existe no acervo → lista "copiar".
- KB não existe → lista "lacunas" (proposta de criação no acervo).

### 4. Confirmar o plano

```text
PLANO DE CRIAÇÃO DO PROJETO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Projeto:  {nome} → {destino}
Stack: {stacks} | Domínio: {dominio} | Cloud: {cloud}

Prompts/instructions/chatmodes a copiar: {core} + {optional com motivo do match}
Excluídos: {lista com motivo — ex.: "instruções Spark — domínio é api-web"}
KBs do acervo a copiar: {lista}
LACUNAS — KBs a criar NO TEMPLATE antes da cópia: {lista}
Instruções/contexto de DOMÍNIO a criar NO FILHO: domain.instructions.md + {projeto}.chatmode.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Confirmar? (sim / ajustar)
```

A criação de KB no acervo central **sempre exige confirmação explícita** — propaga para todos os projetos futuros.

### 5. Criar KBs faltantes no acervo (template)
Para cada lacuna confirmada, use o chat mode **kb-architect** (#file:.github/chatmodes/kb-architect.chatmode.md),
**uma KB por vez**, seguindo os templates de `.github/context/_templates/`. Conhecimento geral da
tecnologia, **sem** contexto de negócio. Depois:
1. Registrar em `.github/context/_index.yaml`.
2. Registrar em `catalog.yaml` (seção `context:`) com `stacks`/`domains`/`last_validated`/`library_version`.

### 6. Copiar seletivamente para o destino

```text
COPIAR:
  .github/prompts/        → tudo, EXCETO new-project.prompt.md
  .github/instructions/   → core + as que casam com o stack
  .github/chatmodes/      → core (spec-driven, code-reviewer) + as que casam
  .github/context/{kb}/   → apenas KBs selecionadas
  .github/context/_templates/ → tudo
  .github/context/_index.yaml → reescrever contendo APENAS as KBs copiadas
  .github/copilot-instructions.md → copiar e preencher (passo 8)
  docs/sdd/  e  docs/dev/ → tudo (templates, exemplos, contratos)
NÃO COPIAR:
  catalog.yaml, setup.sh, README.md, new-project.prompt.md, arquivos .DS_Store
CRIAR:
  .gitignore (.DS_Store, __pycache__/, *.pyc, .env, node_modules/, .venv/)
```

### 7. Criar contexto de domínio no filho
- `.github/instructions/domain.instructions.md` com entidades e regras de negócio de P1/P6.
- `.github/chatmodes/{projeto}.chatmode.md` — persona especialista do projeto (recebe o contexto de negócio).
- Nenhum `{placeholder}` pode restar; os caminhos de KB devem ser os reais copiados.

### 8. Preencher copilot-instructions.md e gravar vínculo
Substitua todos os `[placeholder]` por conteúdo real de P1–P6 (incluindo tabela de KBs copiadas).
Crie `{filho}/.github/template-link.yaml`:

```yaml
template_path: {caminho absoluto deste template}
template_version: {SHA do passo 1}
catalog_version: {version do catalog.yaml}
created_at: "{hoje}"
components:
  prompts: [...]
  instructions: [...]
  chatmodes: [...]
  context_kbs: [...]
```

### 9. Commits e relatório
- **No template** (se criou KB): `git commit -m "feat(kb): adiciona KBs ao acervo via new-project ({nome})"`.
- **No filho:** `git init && git add . && git commit -m "feat: initialize {nome} from copilot-agentspec ({SHA curto})"`.

```text
PROJETO CRIADO
━━━━━━━━━━━━━━━━━━━━
✓ Destino: {caminho}
✓ Componentes copiados: {n}  |  KBs: {n}  |  KBs novas no acervo: {n}
✓ Domínio criado: domain.instructions.md + {projeto}.chatmode.md
✓ copilot-instructions.md preenchido | template-link.yaml gravado ({SHA curto})
PRÓXIMOS PASSOS: cd {caminho} → abrir no VS Code → adicionar código →
  #file:.github/prompts/sync-context.prompt.md → primeira feature com #01-brainstorm/#02-define
```

---

## Gate de qualidade

```text
[ ] catalog.yaml lido e SHA capturado
[ ] Destino validado (inexistente ou vazio)
[ ] Entrevista completa (P1–P5; P6 oferecida) e respostas normalizadas
[ ] Plano apresentado com seleção, exclusões (com motivo) e lacunas
[ ] Criação de KB no acervo confirmada explicitamente
[ ] KBs novas registradas em _index.yaml E catalog.yaml
[ ] Filho contém só os componentes selecionados (sem new-project.prompt.md, sem catalog.yaml)
[ ] _index.yaml do filho lista só as KBs copiadas; sem {placeholder} em lugar nenhum
[ ] template-link.yaml gravado | commits feitos | relatório exibido
```

## Casos especiais

| Situação | Ação |
|----------|------|
| Rodado fora do template (sem catalog.yaml) | Abortar e orientar `#00-project-init` dentro do projeto |
| Destino existe com conteúdo | Abortar — nunca sobrescrever |
| Stack sem mapeamento de KB | Propor criação mesmo assim (kb-architect pesquisa) |
| Usuário recusa criar KB no acervo | Prosseguir sem ela; filho pode criar depois via `#create-kb` |
| git indisponível | Pular commits, registrar aviso, não bloquear |

**Fallback sem seleção:** `setup.sh` (copia tudo) + `#file:.github/prompts/00-project-init.prompt.md` no filho.
