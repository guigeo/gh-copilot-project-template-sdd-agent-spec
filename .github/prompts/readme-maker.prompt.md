---
description: "Gera um README.md completo do projeto a partir do código e do copilot-instructions.md (visão, instalação, uso, arquitetura, contribuição)"
mode: agent
---

# Prompt: README Maker — gerar README do projeto

Gere (ou atualize) o `README.md` do projeto a partir do código real e do
`#file:.github/copilot-instructions.md`. Nada de placeholders soltos — extraia dos fatos do repo.

## Processo

1. **Coletar fatos** — `copilot-instructions.md`, `pyproject.toml`/`package.json`, estrutura de pastas,
   scripts/comandos, variáveis de ambiente (`.env.example`), entrypoints.
2. **Inferir** instalação e uso a partir do gerenciador detectado (ex.: `uv`, `npm`, `poetry`).
3. **Montar** o README com as seções abaixo. Omita seções sem informação real (não invente).

## Estrutura do README

```markdown
# {Nome do Projeto}
> {descrição em uma linha}

## Visão geral        # problema + solução em 2-3 frases
## Stack              # tecnologias principais
## Requisitos         # versões / ferramentas
## Instalação         # passos reais (do gerenciador detectado)
## Uso                # exemplos de comando reais
## Arquitetura        # diagrama/fluxo resumido (do copilot-instructions)
## Estrutura          # árvore de pastas comentada
## Desenvolvimento    # testes, lint, workflow SDD (prompts em .github/prompts/)
## Licença
```

## Regras

- Comandos de instalação/uso devem refletir o gerenciador e scripts **reais** do projeto.
- Linkar arquivos com caminho relativo clicável.
- Tom objetivo; sem marketing vazio.

Mostre o README proposto antes de sobrescrever um existente.
