# Prompt: Build — Fase 3 do SDD

Vou implementar a feature seguindo o DESIGN especificado.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

Referencie o documento de Design:
`#file:docs/sdd/features/DESIGN_{FEATURE}.md`

Se houver KBs relevantes, referencie:
`#file:.github/context/{tecnologia}/quick-reference.md`

---

## Processo

1. Ler o manifesto de arquivos do DESIGN
2. Implementar cada arquivo na ordem de dependência
3. Para cada arquivo: propor implementação completa e aguardar aprovação
4. Verificar que cada critério de aceite do DEFINE foi atendido
5. Gerar relatório de build

---

## Regras de implementação

- Seguir os padrões de código definidos em `copilot-instructions.md`
- Respeitar os contratos de interface do DESIGN exatamente
- Não adicionar funcionalidades além do especificado (YAGNI)
- Incluir type hints / tipos em todas as assinaturas
- Escrever código sem comentários óbvios — apenas comentários que explicam o "por quê"

---

## Verificação de critérios de aceite

Após a implementação, percorrer cada critério do DEFINE:

```
VERIFICAÇÃO DE ACEITE
━━━━━━━━━━━━━━━━━━━━
[ ] {critério 1} — {status: implementado / pendente / não aplicável}
[ ] {critério 2} — {status}
...
```

---

## Gerar relatório de build

Criar `docs/sdd/features/BUILD_REPORT_{FEATURE_EM_MAIUSCULO}.md`:

```markdown
# Build Report: {Nome da Feature}

**Data:** {data}
**Status:** {Completo / Parcial / Bloqueado}

## Arquivos criados
| Arquivo | Linhas | Propósito |
|---------|--------|-----------|
| {caminho} | {n} | {propósito} |

## Arquivos modificados
| Arquivo | Mudanças |
|---------|---------|
| {caminho} | {descrição das mudanças} |

## Critérios de aceite
| Critério | Status |
|----------|--------|
| {critério} | ✓ / ✗ / Parcial |

## Desvios do DESIGN
{lista de desvios com justificativa, ou "Nenhum"}

## Débito técnico identificado
{itens a resolver depois, ou "Nenhum"}

## Próximo passo
Execute: #file:.github/prompts/05-ship.prompt.md
```

---

## Início

Referencie o DESIGN da feature. Podemos começar pelo primeiro arquivo do manifesto.
