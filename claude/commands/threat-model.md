# /threat-model — Modelagem de Ameaças

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
