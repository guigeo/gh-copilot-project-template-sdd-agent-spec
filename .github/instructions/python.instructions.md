---
applyTo: "**/*.py"
---

# Instruções para código Python

## Padrões obrigatórios

- Type hints em todas as assinaturas de função e variáveis de classe
- Dataclasses para modelos de dados simples, Pydantic para modelos com validação
- Generators em vez de listas para coleções grandes ou lazy evaluation
- Context managers (`with`) para recursos externos (arquivos, conexões, sessões)
- `pathlib.Path` em vez de `os.path`

## Estrutura de funções

```python
def process_item(item: ItemType, config: Config) -> Result:
    """Uma linha descrevendo o propósito — apenas se não óbvio pelo nome."""
    ...
```

## Tratamento de erros

- Capturar exceções específicas, nunca `except Exception` sem re-raise
- Usar exceções de domínio customizadas para erros de negócio
- Logar o contexto relevante antes de re-raise

## Imports

- Ordem: stdlib → third-party → local
- Sem imports circulares — reorganizar módulos se necessário
- Usar imports absolutos em código de produção

## Testes

- Um arquivo de teste por módulo: `test_{modulo}.py`
- Nomear testes: `test_{o_que_testa}_{cenario}`
- Fixtures em `conftest.py` — não duplicar entre arquivos de teste
- Cobrir: caminho feliz + principais casos de erro + casos de borda

## Anti-patterns — nunca fazer

- Variáveis globais mutáveis
- Lógica de negócio em `__init__.py`
- `print()` em código de produção — usar `logging`
- Strings hardcoded que são configuração — usar constantes ou config
