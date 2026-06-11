#!/bin/bash
# setup.sh — Inicializa um novo projeto com o copilot-agentspec template
# Uso: ./setup.sh <nome-do-projeto> [diretorio-destino]

set -e

PROJECT_NAME=${1:-"meu-projeto"}
TARGET_DIR="${2:-"$(pwd)"}/$PROJECT_NAME"
TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -z "$1" ]; then
  echo "Uso: ./setup.sh <nome-do-projeto> [diretorio-destino]"
  echo "Exemplo: ./setup.sh minha-api /Users/joao/Projetos"
  exit 1
fi

echo "Criando projeto: $PROJECT_NAME"
echo "Destino: $TARGET_DIR"
echo ""

mkdir -p "$TARGET_DIR"

# Copia estrutura .github (prompts, chatmodes, instructions, context)
cp -r "$TEMPLATE_DIR/.github" "$TARGET_DIR/.github"

# Copia estrutura docs (sdd + dev)
cp -r "$TEMPLATE_DIR/docs" "$TARGET_DIR/docs"

# new-project é exclusivo do template (template-only) — não deve viver no filho
rm -f "$TARGET_DIR/.github/prompts/new-project.prompt.md"

# Cria .gitignore básico
cat > "$TARGET_DIR/.gitignore" << 'EOF'
.DS_Store
__pycache__/
*.pyc
.env
.env.local
node_modules/
.venv/
*.egg-info/
dist/
build/
EOF

# Inicializa git
cd "$TARGET_DIR"
git init
git add .
git commit -m "feat: initialize project from copilot-agentspec template"

echo ""
echo "Projeto criado com sucesso em: $TARGET_DIR"
echo ""
echo "Próximos passos:"
echo "  1. cd $TARGET_DIR"
echo "  2. Abra no VS Code: code ."
echo "  3. No Copilot Chat, execute o prompt de inicialização:"
echo "     #file:.github/prompts/00-project-init.prompt.md"
echo ""
echo "  O prompt vai guiar a configuração do projeto com perguntas"
echo "  e gerar o copilot-instructions.md com contexto real."
