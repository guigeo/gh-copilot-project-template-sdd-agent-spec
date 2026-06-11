---
description: "Analisa o código e atualiza copilot-instructions.md (estrutura, padrões, stack, prompts, KBs), preservando as seções escritas à mão"
mode: agent
---

# Prompt: Sync Context — atualizar copilot-instructions.md

Analise o repositório e atualize `#file:.github/copilot-instructions.md` com o contexto atual,
**preservando** as seções manuais (contexto de negócio, datas).

## Processo

1. **Ler** o `copilot-instructions.md` atual e separar em seções.
2. **Escanear estrutura** — pastas de código, `package.json`/`pyproject.toml`/`Dockerfile`/`*.tf`.
3. **Extrair padrões** — `@dataclass`, parsers, `def test_`, `async def`, `@router`, imports.
4. **Inventariar componentes** — prompts em `.github/prompts/`, instruções em `.github/instructions/`,
   chat modes em `.github/chatmodes/`, KBs em `.github/context/`.
5. **Aplicar regras de atualização** (abaixo) e escrever.

## Regras de atualização por seção

| Seção | Fonte | Modo |
|-------|-------|------|
| Contexto do Projeto / Negócio | manual | **Preservar** |
| Arquitetura | scan do código | Substituir |
| Estrutura do Projeto | scan de pastas | Substituir |
| Padrões de Código | detecção de padrões | Mesclar |
| Prompts / Instruções / KBs disponíveis | `.github/**` | Substituir |
| Datas importantes | manual | **Preservar** |

**Substituir** = regenerar da fonte · **Mesclar** = adicionar novo, manter customizações · **Preservar** = nunca tocar.

## Flags

`--dry-run` (prévia sem salvar) · `--section {nome}` (só uma seção) · `--force` (ignora preservação).

## Saída

```text
SYNC CONTEXT
━━━━━━━━━━━━
✓ {n} arquivos de código | {n} prompts | {n} instruções | {n} KBs
Atualizações: Arquitetura (UPDATED) · Estrutura (UPDATED) · Padrões (MERGED) · Contexto (PRESERVED)
```

Rode após adicionar código-fonte significativo, novos prompts/instruções ou mudanças de arquitetura.
