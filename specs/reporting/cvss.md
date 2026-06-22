# Guia — Classificação de Risco (CVSS)

> Definido por `classificacao_risco` no CONFIG. Use para dar uma severidade
> consistente a cada achado.

## Faixas de severidade (CVSS 3.1)

| Severidade | Score | Significado prático |
|------------|-------|---------------------|
| Critical   | 9.0 – 10.0 | Exploração trivial, impacto severo. Corrigir já. |
| High       | 7.0 – 8.9  | Impacto significativo, exploração viável. |
| Medium     | 4.0 – 6.9  | Impacto moderado ou exploração condicionada. |
| Low        | 0.1 – 3.9  | Impacto limitado. |
| None/Info  | 0.0        | Informativo, sem impacto direto. |

## Métricas base (resumo do que avaliar)

**Exploitability:**
- Attack Vector (Network/Adjacent/Local/Physical)
- Attack Complexity (Low/High)
- Privileges Required (None/Low/High)
- User Interaction (None/Required)

**Impact:**
- Confidentiality (None/Low/High)
- Integrity (None/Low/High)
- Availability (None/Low/High)

**Scope:** mudança ou não de escopo de segurança (Unchanged/Changed)

## Boas práticas
- Documente o **vetor CVSS** completo, não só o número
  (ex: `CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N`)
- Considere o **contexto de negócio**: um Medium técnico pode ser High no negócio
- Seja consistente entre achados do mesmo engajamento
- Para bug bounty, alinhe com a tabela de severidade do programa

## Alternativa — OWASP Risk Rating
Se `classificacao_risco: owasp_risk`, calcule:
`Risco = Probabilidade × Impacto`, cada um de fatores de ameaça, vulnerabilidade,
impacto técnico e impacto de negócio.
