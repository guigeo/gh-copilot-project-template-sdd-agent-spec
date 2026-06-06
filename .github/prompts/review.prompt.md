# Prompt: Revisão de Código

Faça uma revisão completa do código referenciado.

**Contexto do projeto:** #file:../.github/copilot-instructions.md

Referencie o(s) arquivo(s) a revisar:
`#file:src/{caminho}/{arquivo}`

---

## O que verificar

### Correção
- [ ] Lógica está correta para os casos de uso declarados?
- [ ] Casos de borda tratados?
- [ ] Erros tratados adequadamente?
- [ ] Condições de corrida ou problemas de concorrência?

### Segurança
- [ ] Inputs do usuário validados?
- [ ] SQL injection, XSS, ou outras vulnerabilidades OWASP?
- [ ] Secrets hardcoded?
- [ ] Permissões e autenticação corretas?

### Qualidade
- [ ] Segue os padrões definidos em `copilot-instructions.md`?
- [ ] Nomes de variáveis/funções são claros?
- [ ] Funções têm responsabilidade única?
- [ ] Código duplicado que poderia ser extraído?

### Performance
- [ ] Queries N+1 ou loops desnecessários?
- [ ] Operações caras dentro de loops?
- [ ] Oportunidades de cache?

---

## Formato de saída

Para cada problema encontrado:

```
**[SEVERITY]** {arquivo}:{linha}
**Problema:** {descrição clara do problema}
**Sugestão:** {como corrigir}
\`\`\`{linguagem}
// código sugerido
\`\`\`
```

Severidades:
- **[CRÍTICO]** — Bug, vulnerabilidade de segurança, corrigir antes de mergear
- **[IMPORTANTE]** — Problema de qualidade significativo, fortemente recomendado corrigir
- **[SUGESTÃO]** — Melhoria opcional, boas práticas

---

## Resumo ao final

```
RESUMO DA REVISÃO
━━━━━━━━━━━━━━━━━
Críticos:    {n}
Importantes: {n}
Sugestões:   {n}

Aprovado para merge: {Sim / Não — resolver críticos primeiro}
```
