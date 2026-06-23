---
name: threat-model
description: "Modelagem de ameaças (PTES Threat Modeling): identifica ativos de valor, vetores de ataque e prioriza por risco com base no recon já feito. Use sempre após /recon ou quando o usuário pedir para 'priorizar', 'modelar ameaças', 'decidir o que testar primeiro' ou 'mapear vetores de ataque'. Não gera tráfego ao alvo — pura análise."
disable-model-invocation: false
allowed-tools: Read, Write, Grep
metadata:
  version: "1.0"
  category: analysis
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Modelagem de Ameaças

Execute a modelagem de ameaças (PTES: Threat Modeling) com base no recon.

## Antes de executar
1. Leia `findings/recon-summary.md`.
2. Carregue o profile do cenário ativo (`specs/scenarios/<cenario>.md`).

## O que fazer
- Identificar os **ativos de valor** ("o que importa proteger").
- Mapear **vetores de ataque** possíveis sobre a superfície descoberta.
- Mapear **fronteiras de confiança** e fluxos de dados sensíveis.
- Modelar o **perfil do atacante** relevante (externo, interno, autenticado).
- Priorizar por **risco** = probabilidade × impacto.

## Saída
Salve em `findings/threat-model.md`:
- Lista de ativos críticos
- Matriz de vetores de ataque priorizados
- Áreas de foco para enumeração (o que testar primeiro)

## Objetivo
Direcionar as próximas fases para o que tem **maior probabilidade de impacto**,
em vez de testar tudo cegamente.
