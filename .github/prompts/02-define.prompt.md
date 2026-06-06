# Prompt: Define — Fase 1 do SDD

Vou capturar e validar os requisitos desta feature de forma estruturada.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

Se houver um documento de Brainstorm, referencie-o:
`#file:docs/sdd/features/BRAINSTORM_{FEATURE}.md`

---

## Processo

1. Extrair requisitos funcionais e não-funcionais
2. Identificar critérios de aceite claros
3. Mapear dependências e riscos
4. Calcular score de clareza (0-100)
5. Se score < 80: fazer perguntas de esclarecimento
6. Gerar `docs/sdd/features/DEFINE_{FEATURE}.md`

---

## Score de clareza

Avaliar o documento gerado contra estes critérios:

| Critério | Peso | Pergunta |
|----------|------|----------|
| Problema claro | 20 | O problema a resolver está bem definido? |
| Escopo delimitado | 20 | O que está dentro e fora do escopo? |
| Critérios de aceite | 25 | Como saberemos que está pronto? |
| Dependências mapeadas | 15 | Quais integrações e sistemas envolvidos? |
| Não-funcionais | 20 | Performance, segurança, escalabilidade? |

Se score < 80: listar as perguntas de esclarecimento necessárias antes de continuar.

---

## Gerar documento de saída

Criar `docs/sdd/features/DEFINE_{FEATURE_EM_MAIUSCULO}.md`:

```markdown
# Define: {Nome da Feature}

**Data:** {data}
**Score de clareza:** {score}/100
**Status:** {Aprovado / Precisa de esclarecimento}

## Problema
{descrição clara do problema}

## Escopo
### Dentro do escopo
- {item}

### Fora do escopo
- {item}

## Requisitos Funcionais
- RF01: {requisito}
- RF02: {requisito}

## Requisitos Não-Funcionais
- RNF01: {performance/segurança/escalabilidade}

## Critérios de Aceite
- [ ] {critério mensurável}
- [ ] {critério mensurável}

## Dependências
- {sistema/serviço externo}

## Riscos
| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| {risco} | Alta/Média/Baixa | Alto/Médio/Baixo | {ação} |

## Próximo passo
Execute: #file:.github/prompts/03-design.prompt.md
```

---

## Início

Descreva a feature que você quer definir, ou referencie um BRAINSTORM existente.
