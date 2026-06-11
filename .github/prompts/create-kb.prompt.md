---
description: "Cria um domínio de Knowledge Base completo em .github/context/{dominio}/ a partir dos templates, com pesquisa em documentação oficial, e registra no índice"
mode: agent
---

# Prompt: Create KB — novo domínio de Knowledge Base

Cria uma KB de tecnologia em `.github/context/{dominio}/`, pronta para ser referenciada com
`#file:` nas fases de Design/Build. Conhecimento **geral da tecnologia**, sem contexto de negócio.

**Templates de KB:** #file:.github/context/_templates/
**Índice:** #file:.github/context/_index.yaml
**Persona recomendada:** chat mode `kb-architect` (#file:.github/chatmodes/kb-architect.chatmode.md)

## Uso

```
#file:.github/prompts/create-kb.prompt.md

Domínio: redis   (ou: pandas, fastapi, authentication...)
```

## Processo

1. **Validar pré-requisitos** — `_templates/` e `_index.yaml` existem; checar se o domínio já existe.
2. **Pesquisar** — buscar a documentação oficial atual (use Context7 / Ref Tools / web) para fundamentar.
3. **Gerar a estrutura** seguindo os templates:
   ```text
   .github/context/{dominio}/
   ├── index.md              # mapa do domínio (entrada)
   ├── quick-reference.md    # referência rápida (máx. ~100 linhas)
   ├── manifest.yaml         # metadados (stacks, domains, last_validated, library_version)
   ├── concepts/             # ≥ 2 conceitos fundamentais
   └── patterns/             # ≥ 1 padrão prático (copiável)
   ```
4. **Registrar** — adicionar o domínio em `.github/context/_index.yaml` e, se estiver no template,
   em `catalog.yaml` (seção `context:`) com `stacks`/`domains`/`last_validated`/`library_version`.
5. **Relatar** — arquivos criados + checagem de limites de tamanho.

## Gate de qualidade

```text
[ ] quick-reference.md ≤ ~100 linhas e copiável
[ ] ≥ 2 concepts e ≥ 1 pattern
[ ] manifest.yaml preenchido (sem placeholder) com last_validated = hoje
[ ] Registrado no _index.yaml (e no catalog.yaml se no template)
[ ] Conteúdo é genérico — sem entidades/regras de negócio de nenhum projeto
```

Opção: `--audit` → auditar a saúde das KBs existentes (tamanho, frescor de `last_validated`, lacunas).
