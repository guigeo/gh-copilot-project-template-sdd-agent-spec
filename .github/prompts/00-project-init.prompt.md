# Prompt: Inicialização do Projeto

Vou te fazer 6 perguntas para configurar este projeto. Responda uma a uma.
Ao final, vou gerar o conteúdo de `.github/copilot-instructions.md`, criar a estrutura de
Knowledge Base e sugerir os arquivos de instruções de domínio.

---

## Pergunta 1 — Identidade do projeto

O que é este projeto? Me dê uma frase.

Exemplo: "Uma API REST que ingere dados de sensores e armazena no PostgreSQL"

---

## Pergunta 2 — Stack tecnológico

Qual é o seu stack? Liste as principais linguagens, frameworks e bibliotecas.

Exemplos:
- Python + FastAPI + SQLAlchemy + PostgreSQL
- TypeScript + Next.js + Prisma + Supabase
- Python + PySpark + Delta Lake + Databricks
- Python + AWS Lambda + S3 + DynamoDB

---

## Pergunta 3 — Domínio

Qual domínio melhor descreve este projeto?
(a) API Web / Serviço backend
(b) Pipeline de dados / ETL
(c) Aplicação AI / ML / LLM
(d) Ferramenta CLI / Automação de scripts
(e) Frontend / Full-stack
(f) Infraestrutura / DevOps
(g) Outro: [descreva]

---

## Pergunta 4 — Cloud / Infraestrutura

Onde este projeto roda?
(a) AWS (Lambda / EC2 / ECS)
(b) GCP (Cloud Run / Cloud Functions)
(c) Azure (Functions / AKS)
(d) Databricks
(e) Local / On-premise
(f) Múltiplos / Híbrido

---

## Pergunta 5 — Equipe e contexto

Contexto rápido da equipe:
(a) Projeto solo
(b) Equipe pequena (2-5 pessoas)
(c) Equipe maior (6+)

E mais: Existe algum problema ou restrição específica que devo saber?
(Opcional — pode pular se não for relevante)

---

## Pergunta 6 — Contexto adicional (opcional)

Você tem algum documento ou detalhe adicional para compartilhar?

Pode colar aqui:
- PRD (documento de requisitos do produto)
- Notas de reunião ou briefing
- Regras de negócio específicas
- Restrições técnicas ou arquiteturais

(Opcional — se não tiver, pode pular com "não")

---

## O que fazer com as respostas

Após receber todas as respostas, gerar:

### 1. Conteúdo atualizado de `.github/copilot-instructions.md`

Substituir todos os `[placeholder]` com conteúdo real:
- Nome e descrição do projeto
- Stack tecnológico
- Convenções de código inferidas do stack
- Contexto de negócio e regras extraídas do PRD (se fornecido)
- Entidades principais do domínio

### 2. Lista de arquivos de contexto KB a criar em `.github/context/`

Para cada tecnologia do stack, sugerir a criação de um arquivo de referência:
```
.github/context/
├── {tecnologia-1}/
│   └── quick-reference.md
├── {tecnologia-2}/
│   └── quick-reference.md
└── domain/
    └── business-rules.md      ← regras de negócio do projeto
```

**Instrução:** Para cada KB sugerido, pergunte ao usuário "Devo gerar o conteúdo de `.github/context/{tecnologia}/quick-reference.md`?"
Se sim, busque a documentação oficial e gere um guia de referência rápida focado no uso neste projeto.

### 3. Arquivos de instruções de domínio

Sugerir e criar `.github/instructions/domain.instructions.md` com:
- Entidades do domínio
- Regras de negócio
- Padrões específicos do projeto

### 4. Confirmação

Ao final, mostrar:
```
PROJETO INICIALIZADO
━━━━━━━━━━━━━━━━━━━━

✓ copilot-instructions.md atualizado
✓ KBs sugeridos: {lista}
✓ Instruções de domínio: domain.instructions.md

PRÓXIMOS PASSOS:
1. Adicione código-fonte e o Copilot vai usar o contexto automaticamente
2. Para começar uma feature: use #file:.github/prompts/01-brainstorm.prompt.md
3. Para adicionar KB de uma lib: peça "gere .github/context/{lib}/quick-reference.md"
```
