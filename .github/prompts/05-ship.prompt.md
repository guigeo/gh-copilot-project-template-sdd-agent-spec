# Prompt: Ship — Fase 4 do SDD

Vou arquivar esta feature e capturar lições aprendidas.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

Referencie o relatório de build:
`#file:docs/sdd/features/BUILD_REPORT_{FEATURE}.md`

---

## Processo

1. Verificar que todos os critérios de aceite foram atendidos
2. Capturar lições aprendidas
3. Arquivar todos os artefatos em `docs/sdd/archive/{feature}/`
4. Atualizar `copilot-instructions.md` com o registro da feature

---

## Checklist pré-ship

```
PRÉ-SHIP
━━━━━━━━
[ ] Todos os critérios de aceite do DEFINE atendidos
[ ] Testes passando
[ ] Sem TODO/FIXME críticos no código
[ ] Documentação atualizada se necessário
[ ] PR/MR pronto para revisão
```

Se algum item não estiver marcado, NÃO arquivar — resolver primeiro.

---

## Arquivar artefatos

Mover os seguintes arquivos de `docs/sdd/features/` para `docs/sdd/archive/{FEATURE}/`:
- `BRAINSTORM_{FEATURE}.md` (se existir)
- `DEFINE_{FEATURE}.md`
- `DESIGN_{FEATURE}.md`
- `BUILD_REPORT_{FEATURE}.md`

---

## Gerar documento de lições aprendidas

Criar `docs/sdd/archive/{FEATURE}/SHIPPED_{DATA}.md`:

```markdown
# Shipped: {Nome da Feature}

**Data de entrega:** {data}
**Duração:** {estimativa do início ao fim}

## O que foi construído
{resumo em 2-3 frases}

## Arquivos entregues
{lista do manifesto de build}

## O que funcionou bem
- {lição positiva 1}
- {lição positiva 2}

## O que pode melhorar
- {lição de melhoria 1}
- {lição de melhoria 2}

## Débito técnico registrado
- {item de débito ou "Nenhum"}

## Impacto no projeto
{como esta feature muda o projeto — novas dependências, padrões estabelecidos}
```

---

## Atualizar copilot-instructions.md

Adicionar a feature na seção de features entregues (se existir) ou criar:

```markdown
## Features Entregues

| Feature | Data | Descrição |
|---------|------|-----------|
| {nome} | {data} | {descrição em uma linha} |
```

---

## Início

Referencie o BUILD_REPORT e confirme que o checklist pré-ship está completo.
