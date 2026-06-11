---
description: "Roda NO PROJETO FILHO — devolve ao template (write-back) o conhecimento reaproveitável (KBs de tecnologia, instruções/chat modes de papel técnico), deixando o que é específico do negócio"
mode: agent
---

# Prompt: Contribute — write-back filho → template

> Roda **dentro de um projeto filho**. Fecha o ciclo da biblioteca central: o que nasceu aqui
> e serve a outros projetos volta para o acervo do template.
>
> **Regra de ouro:** só volta o reaproveitável (tecnologia ou papel técnico). Contexto de
> negócio **nunca** volta — fica no filho.

**Vínculo com o template:** `#file:.github/template-link.yaml`

## Uso

```
#file:.github/prompts/contribute.prompt.md          # analisa tudo e propõe candidatos
#file:.github/prompts/contribute.prompt.md  kb pyspark
```

---

## O que volta e o que NÃO volta

| Volta (reaproveitável) | Fica só no filho (específico) |
|------------------------|-------------------------------|
| KB de tecnologia (`.github/context/{tech}/`) | KB de regra de negócio |
| Instrução de papel técnico (`python`, `sql`...) | `domain.instructions.md` |
| Chat mode genérico (ex.: `api-developer`) | `{projeto}.chatmode.md` |
| Melhoria num componente que veio do template | Decisões de arquitetura do projeto |

Critério: *"outro projeto, de outro domínio, usaria isto sem editar?"* Se depende do negócio → **não volta**.

## Processo

1. **Localizar o template** — ler `template-link.yaml` (`template_path`, `components`). Se ausente,
   este projeto não nasceu via `new-project`: pedir o caminho do template ou abortar. Validar que `template_path` tem `catalog.yaml`.
2. **Detectar candidatos** — comparar o filho com o template:
   ```text
   context KBs:   .github/context/*/        vs  {template}/.github/context/*/
   instructions:  .github/instructions/*    vs  {template}/.github/instructions/*
   chatmodes:     .github/chatmodes/*       vs  {template}/.github/chatmodes/*
   ```
   Classificar: NOVO no filho → candidato; EXISTE em ambos e filho modificado → candidato a atualizar (mostrar diff); só no template → ignorar.
   Excluir automaticamente: `domain.instructions.md`, `{projeto}.chatmode.md`, e qualquer item que cite entidades/regras/dados do projeto (varrer nomes do negócio que aparecem no `copilot-instructions.md`).
3. **Triagem** — ler cada candidato e decidir: reaproveitável puro / reaproveitável contaminado (limpar contexto de negócio antes) / específico (descartar com motivo).
4. **Confirmar o plano:**
   ```text
   PLANO DE CONTRIBUIÇÃO → {template_path}
   Contribuir como está: {lista}
   Contribuir após limpar contexto de negócio: {lista → versão genérica}
   Atualizar no template (filho tem versão melhor): {lista + resumo do diff}
   Descartado (específico): {lista + motivo}
   Confirmar? (sim / ajustar / escolher itens)
   ```
   Escrita no acervo propaga para todos os projetos futuros — **sempre confirmar**.
5. **Aplicar no template:**
   ```text
   KB novo:        copiar .github/context/{kb}/ → {template}/.github/context/{kb}/
                   registrar em {template}/.github/context/_index.yaml e em {template}/catalog.yaml (context:)
   KB atualizado:  sobrescrever no template; atualizar last_validated no catalog.yaml
   Instrução/mode: escrever versão generalizada em {template}/.github/{instructions|chatmodes}/
                   registrar em {template}/catalog.yaml com scope/stacks/domains
   ```
   Ao generalizar: remover nome `{projeto}-*`, trocar exemplos do projeto por neutros, remover bloco de contexto de negócio, ajustar caminhos de KB.
6. **Commit no template e relatório:**
   ```text
   cd {template_path} && git add .github/context .github/instructions .github/chatmodes catalog.yaml
   git commit -m "feat: contribuições de {filho} ({resumo})"
   ```
   ```text
   CONTRIBUIÇÃO CONCLUÍDA → {template_path}
   ✓ KBs contribuídas / instruções e chat modes generalizados / itens atualizados / descartados (n)
   Lembre-se: o template é outro repositório — faça git push lá para publicar.
   ```

## Gate de qualidade

```text
[ ] template-link.yaml lido e template_path validado
[ ] {projeto}.chatmode.md, domain.instructions.md e itens com negócio excluídos automaticamente
[ ] Cada candidato lido e triado (puro/contaminado/específico)
[ ] Contaminados generalizados (sem {projeto}, sem regra de negócio)
[ ] Plano confirmado antes de escrever no acervo
[ ] KBs novas registradas em _index.yaml E catalog.yaml do template
[ ] Nenhum dado/entidade do projeto vazou para o acervo | commit feito | relatório lembra do git push
```
