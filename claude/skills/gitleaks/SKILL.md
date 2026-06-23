---
name: gitleaks
description: "Detecta segredos commitados em repositórios git AUTORIZADOS no escopo, incluindo histórico, usando gitleaks e trufflehog (com --only-verified). Use quando o usuário pedir para 'analisar repositório', 'gitleaks', 'segredos no git' ou 'trufflehog'. Confirme que o repo está in-scope."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: passive-recon
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Segredos em Repositórios Git

Detecta segredos commitados em repositórios git (incluindo histórico). Aplicável
a repos públicos da organização que estejam no escopo, ou a código fornecido em
testes white-box.

## Pré-checagem
- **Só analise repositórios autorizados no escopo.** Repos públicos de terceiros
  ou de funcionários a título pessoal geralmente estão fora — confirme.

## Ferramentas e uso

```bash
# gitleaks — scan de um repo local (inclui histórico de commits)
gitleaks detect --source ./repo-alvo --report-format json --report-path gitleaks.json

# Scan de um repo remoto autorizado
git clone https://github.com/org-alvo/repo.git
gitleaks detect --source ./repo --report-path gitleaks_repo.json

# trufflehog — segredos VERIFICADOS (reduz falsos positivos)
trufflehog git https://github.com/org-alvo/repo.git --only-verified --json > trufflehog.json

# trufflehog em filesystem (código white-box)
trufflehog filesystem ./codigo-fonte --only-verified --json > trufflehog_fs.json
```

## O que detecta
- Chaves de API, tokens, senhas no código e no **histórico** (mesmo que removidas depois)
- Arquivos `.env`, credenciais de banco, chaves privadas
- Segredos verificados (trufflehog testa se ainda são válidos)

## Validação
- `--only-verified` (trufflehog) confirma segredos ativos — priorize esses.
- **Não use os segredos** para acessar sistemas além de validar; reporte a exposição.
- Mascare valores no relatório.

## Saída
- `findings/recon/gitleaks*.json` / `trufflehog*.json`
- Segredos confirmados → `findings/F-XXX-*.md` (A02 — falhas criptográficas /
  exposição de dados sensíveis), com remediação (rotacionar a chave, limpar histórico).

> O histórico git é a parte mais valiosa — segredos "deletados" continuam lá.
> Escopo é essencial: só repos autorizados.
