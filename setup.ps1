<#
.SYNOPSIS
  Inicializa um novo projeto com o copilot-agentspec template (Windows / PowerShell).
.DESCRIPTION
  Equivalente ao setup.sh. Copia .github e docs, remove o prompt template-only,
  cria .gitignore e inicializa o git.
.EXAMPLE
  .\setup.ps1 minha-api
  .\setup.ps1 meu-saas C:\Users\joao\Projetos
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$ProjectName,

  [Parameter(Position = 1)]
  [string]$DestinationDir = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

$TemplateDir = $PSScriptRoot
$TargetDir = Join-Path $DestinationDir $ProjectName

Write-Host "Criando projeto: $ProjectName"
Write-Host "Destino: $TargetDir"
Write-Host ""

if (Test-Path $TargetDir) {
  $existing = Get-ChildItem -Force $TargetDir -ErrorAction SilentlyContinue
  if ($existing) {
    Write-Error "O destino '$TargetDir' já existe e não está vazio. Abortando para não sobrescrever."
    exit 1
  }
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

# Copia estrutura .github (prompts, chatmodes, instructions, context)
Copy-Item -Recurse -Force (Join-Path $TemplateDir '.github') (Join-Path $TargetDir '.github')

# Copia estrutura docs (sdd + dev)
Copy-Item -Recurse -Force (Join-Path $TemplateDir 'docs') (Join-Path $TargetDir 'docs')

# new-project é exclusivo do template (template-only) — não deve viver no filho
Remove-Item -Force (Join-Path $TargetDir '.github\prompts\new-project.prompt.md') -ErrorAction SilentlyContinue

# Cria .gitignore básico
@'
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
'@ | Set-Content -Encoding utf8 (Join-Path $TargetDir '.gitignore')

# Inicializa git
Push-Location $TargetDir
try {
  git init | Out-Null
  git add .
  git commit -m "feat: initialize project from copilot-agentspec template" | Out-Null
}
finally {
  Pop-Location
}

Write-Host ""
Write-Host "Projeto criado com sucesso em: $TargetDir"
Write-Host ""
Write-Host "Próximos passos:"
Write-Host "  1. cd $TargetDir"
Write-Host "  2. Abra no VS Code: code ."
Write-Host "  3. No Copilot Chat, execute o prompt de inicialização:"
Write-Host "     #file:.github/prompts/00-project-init.prompt.md"
Write-Host ""
Write-Host "  O prompt vai guiar a configuração do projeto com perguntas"
Write-Host "  e gerar o copilot-instructions.md com contexto real."
