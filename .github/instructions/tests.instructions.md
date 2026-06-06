---
applyTo: "**/test_*.py,**/*.test.ts,**/*.spec.ts,**/*.test.js"
---

# Instruções para arquivos de teste

## Estrutura de um teste bem escrito

```python
def test_{o_que_faz}_{cenario_ou_condicao}():
    # Arrange — prepare o estado
    ...

    # Act — execute a ação
    result = funcao_sendo_testada(...)

    # Assert — verifique o resultado
    assert result == expected
```

## O que sempre testar

1. **Caminho feliz** — o fluxo normal com dados válidos
2. **Inputs inválidos** — o que acontece com dados errados
3. **Casos de borda** — vazio, None, zero, string vazia, lista enorme
4. **Erros esperados** — use `pytest.raises(ExcecaoEsperada)`

## Fixtures

- Colocar fixtures compartilhadas em `conftest.py`
- Fixtures devem ter escopo mínimo necessário (`function` > `module` > `session`)
- Fixtures de banco de dados devem usar rollback após cada teste

## Mocks

- Usar `unittest.mock.patch` ou `pytest-mock` para isolar dependências externas
- Mockar na fronteira do sistema — não mockar lógica de negócio interna
- Verificar que mocks foram chamados com os argumentos corretos quando relevante

## Nunca fazer em testes

- Testes que dependem de ordem de execução
- Dados hardcoded que dependem do ambiente (paths absolutos, portas fixas)
- Testes que fazem chamadas reais a APIs externas (sem flag explícita de integração)
- Assertions sem mensagem quando o motivo não é óbvio
