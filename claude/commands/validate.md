# /validate — Validação de Vulnerabilidades

Confirme as vulnerabilidades suspeitas com prova mínima e reproduzível.

## Antes de executar
1. Liste os achados com status `Suspeito` em `findings/`.
2. Verifique a `profundidade` no CONFIG — só confirme dentro do permitido.

## O que fazer
Para cada achado suspeito:
- Confirmar de forma **reproduzível** e com **impacto mínimo necessário**.
- Coletar **evidência** clara (request/response, prints, logs) em `evidence/`.
- **Mascarar** dados sensíveis (PII, credenciais reais) → `[REDACTED]`.
- Atribuir **severidade** via `specs/reporting/cvss.md`.
- Mapear à **categoria OWASP** (Web Top 10 ou API Top 10).
- Atualizar o status para `Confirmado` ou `Falso-positivo`.

## Regras
- Para provar acesso indevido, use **contas de teste** fornecidas no escopo —
  nunca dados de usuários reais.
- Pare na prova de conceito. Não escale além do necessário para demonstrar o risco,
  a menos que `permite_pos_exploracao: true` e isso faça parte do objetivo.
- Achado crítico → comunique imediatamente o contato do escopo antes de prosseguir.

## Saída
Achados em `findings/` atualizados com status final, severidade, CVSS, categoria
OWASP e referência às evidências.
