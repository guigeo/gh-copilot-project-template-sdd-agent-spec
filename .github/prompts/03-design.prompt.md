# Prompt: Design — Fase 2 do SDD

Vou criar a arquitetura técnica e especificação de implementação desta feature.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

Referencie o documento de Define:
`#file:docs/sdd/features/DEFINE_{FEATURE}.md`

Se houver KBs relevantes para o stack, referencie também:
`#file:.github/context/{tecnologia}/quick-reference.md`

---

## Processo

1. Analisar requisitos do DEFINE
2. Propor arquitetura técnica alinhada ao stack do projeto
3. Criar manifesto de arquivos a criar/modificar
4. Definir contratos de interface (APIs, schemas, tipos)
5. Identificar casos de teste necessários
6. Gerar `docs/sdd/features/DESIGN_{FEATURE}.md`

---

## Decisões arquiteturais

Para cada decisão relevante, documentar no formato:

```
**Decisão:** {o que foi decidido}
**Alternativas consideradas:** {o que foi avaliado}
**Justificativa:** {por que esta escolha}
**Trade-offs:** {o que se perde com esta escolha}
```

---

## Manifesto de arquivos

Listar todos os arquivos que serão criados ou modificados:

```
CRIAR:
  src/{caminho}/{arquivo}.py — {propósito}

MODIFICAR:
  src/{caminho}/{arquivo-existente}.py — {o que muda}

TESTES:
  tests/{caminho}/test_{arquivo}.py — {o que testar}
```

---

## Gerar documento de saída

Criar `docs/sdd/features/DESIGN_{FEATURE_EM_MAIUSCULO}.md`:

```markdown
# Design: {Nome da Feature}

**Data:** {data}
**Status:** Pronto para implementação

## Visão Geral da Arquitetura
{diagrama em texto ou descrição do fluxo}

## Decisões Arquiteturais
{decisões no formato acima}

## Manifesto de Arquivos
{lista completa}

## Contratos de Interface
### {Nome da API/Schema}
\`\`\`{linguagem}
{definição do contrato}
\`\`\`

## Casos de Teste
- [ ] {caso de teste 1}
- [ ] {caso de teste 2}

## Estimativa de Complexidade
**Esforço:** {Baixo / Médio / Alto}
**Justificativa:** {raciocínio}

## Próximo passo
Execute: #file:.github/prompts/04-build.prompt.md
```

---

## Início

Referencie o DEFINE da feature e descreva qualquer restrição arquitetural adicional.
