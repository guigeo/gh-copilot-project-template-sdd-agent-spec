# Prompt: Brainstorm — Fase 0 do SDD

Vou explorar esta ideia de feature com você antes de capturar requisitos formais.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

---

## Processo

Vou fazer perguntas **uma de cada vez** para entender a ideia.
Após pelo menos 3 perguntas, vou propor 2-3 abordagens com trade-offs.
Ao final, gero o documento `docs/sdd/features/BRAINSTORM_{FEATURE}.md`.

---

## Perguntas de descoberta

Começarei com:

**"O que você quer construir? Descreva em 1-2 frases."**

Depois vou perguntar:
- Por que este problema precisa ser resolvido agora?
- Quem vai usar isso?
- O que o sucesso parece? Como vamos medir?
- Você tem exemplos de input/output esperados?
- Existem restrições técnicas que devo saber?

---

## Após as perguntas: propor abordagens

Apresentar 2-3 abordagens distintas no formato:

```
### Abordagem A: {Nome} ⭐ Recomendada
**Por quê:** {raciocínio}
**Prós:** {benefícios}
**Contras:** {trade-offs}

### Abordagem B: {Nome}
**Por que não é a recomendada:** {raciocínio}
```

---

## Aplicar YAGNI

Para cada funcionalidade proposta, questionar:
- Isso é necessário para o MVP?
- Resolve o problema central?

Documentar o que foi removido e por quê.

---

## Gerar documento de saída

Criar `docs/sdd/features/BRAINSTORM_{FEATURE_EM_MAIUSCULO}.md` com:

```markdown
# Brainstorm: {Nome da Feature}

**Data:** {data}
**Status:** Em análise

## Ideia central
{descrição}

## Problema a resolver
{problema identificado}

## Abordagem escolhida
{abordagem selecionada e justificativa}

## Abordagens descartadas
{o que foi descartado e por quê}

## Funcionalidades YAGNI removidas
{o que foi cortado para MVP}

## Requisitos preliminares
{lista de requisitos identificados}

## Próximo passo
Execute: #file:.github/prompts/02-define.prompt.md
```

---

## Início

Qual é a ideia ou problema que você quer explorar?
