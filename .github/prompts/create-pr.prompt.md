---
description: "Prepara e abre um Pull Request: analisa o diff da branch, escreve título/descrição estruturados e cria o PR com gh CLI"
mode: agent
---

# Prompt: Create PR — abrir Pull Request

Prepare e abra um PR a partir das mudanças da branch atual.

## Processo

1. **Inspecionar** — `git status`, `git diff` contra a branch base, e os commits da branch.
2. **Branch** — se estiver na branch default (`main`/`master`), criar uma branch antes (`feat/...`, `fix/...`).
3. **Mensagem** — agrupar as mudanças por tema; não listar arquivo a arquivo cru.
4. **Abrir** com `gh pr create` usando o corpo abaixo.

## Corpo do PR

```markdown
## Resumo
{1-3 bullets do que muda e por quê}

## Mudanças
- {mudança relevante 1}
- {mudança relevante 2}

## Como testar
{passos para validar}

## Notas
{decisões, trade-offs, follow-ups — ou "Nenhuma"}
```

## Regras

- Confirme com o usuário antes de criar o PR (ação externa).
- Vincule o artefato SDD se houver: `docs/sdd/features/DEFINE_{FEATURE}.md`.
- Não force push em branch compartilhada; não inclua segredos no diff.
- Se a feature seguiu o SDD, reaproveite o `BUILD_REPORT` como base do corpo.
