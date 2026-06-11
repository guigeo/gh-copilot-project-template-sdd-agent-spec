---
applyTo: "**/*.sql"
---

# Instruções para SQL

## Estilo e legibilidade

- Palavras-chave em MAIÚSCULAS (`SELECT`, `FROM`, `JOIN`, `WHERE`); identificadores em `snake_case`.
- Uma coluna por linha em `SELECT`; `JOIN`/`WHERE` indentados e alinhados.
- CTEs (`WITH ... AS`) em vez de subqueries aninhadas profundas — nomeie cada etapa do pipeline.
- Sem `SELECT *` em código de produção — liste as colunas explicitamente.

## Correção e segurança

- **Nunca** concatenar input em string SQL — usar queries parametrizadas / binds.
- `JOIN` sempre com condição explícita (`ON`); evitar joins cartesianos acidentais.
- Cuidado com `NULL` em filtros e agregações (`= NULL` nunca casa — use `IS NULL`).
- Filtros que reduzem cardinalidade o mais cedo possível.

## Performance

- Evitar funções sobre colunas no `WHERE` quando isso impede uso de índice/partição.
- Em data lakes (Spark/Delta), filtrar por coluna de **partição** quando existir (partition pruning).
- Preferir agregações incrementais a recomputar tudo; materializar etapas caras quando reaproveitadas.
- Revisar o plano (`EXPLAIN`) em queries pesadas.

## Modelagem (analytics / medalhão)

- Camadas: bronze (bruto) → silver (limpo/conformado) → gold (modelado para consumo).
- Chaves naturais documentadas; deduplicação explícita por chave + critério de recência.
- Tipos e nomes consistentes entre camadas; contratos de schema estáveis na silver/gold.

> Para padrões de Spark/Delta/Lakeflow e qualidade de dados, referencie as KBs:
> `#file:.github/context/delta-lake/quick-reference.md`,
> `#file:.github/context/arquitetura-medalhao/quick-reference.md`,
> `#file:.github/context/qualidade-de-dados/quick-reference.md`.
