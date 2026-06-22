# Metodologia — OWASP API Security Top 10 (2023)

> Ative com `metodologias.owasp_api_top10: true`. Específica para alvos de API.
> Combine com o profile `specs/scenarios/api.md`.

## As 10 categorias

### API1 — Broken Object Level Authorization (BOLA)
Acesso a objetos de outros usuários manipulando IDs. O equivalente a IDOR em APIs.
**Mais crítica e comum em APIs.**

### API2 — Broken Authentication
Mecanismos de autenticação falhos: tokens fracos, JWT mal validado, ausência de
expiração, credential stuffing.

### API3 — Broken Object Property Level Authorization
Exposição ou modificação de propriedades de objeto que o usuário não deveria
acessar (mass assignment + excessive data exposure unificados).

### API4 — Unrestricted Resource Consumption
Ausência de limites de uso: rate limiting, paginação, tamanho de payload —
abre espaço para DoS e custos excessivos.

### API5 — Broken Function Level Authorization (BFLA)
Acesso a funções/endpoints administrativos por usuários comuns.

### API6 — Unrestricted Access to Sensitive Business Flows
Fluxos de negócio sensíveis (compra, criação em massa) sem proteção contra abuso
automatizado.

### API7 — Server Side Request Forgery (SSRF)
API busca recursos externos a partir de URL fornecida pelo usuário sem validação.

### API8 — Security Misconfiguration
Configuração insegura: CORS permissivo, headers ausentes, métodos HTTP expostos,
verbosidade de erros.

### API9 — Improper Inventory Management
Endpoints/versões antigas ("shadow"/"zombie" APIs) expostos e esquecidos. Falta de
documentação e inventário.

### API10 — Unsafe Consumption of APIs
Confiar cegamente em dados de APIs de terceiros sem validação.

## Checklist específico de API

- [ ] Enumerar endpoints (Swagger/OpenAPI, JS, mobile, tráfego)
- [ ] Testar BOLA: trocar IDs entre contas
- [ ] Testar BFLA: acessar rotas admin com token de usuário comum
- [ ] Validar JWT: assinatura, alg=none, expiração, claims
- [ ] Verificar mass assignment em payloads de criação/edição
- [ ] Verificar excessive data exposure nas respostas
- [ ] Testar rate limiting e limites de payload
- [ ] Procurar versões antigas (/v1, /v2, /beta, /internal)
- [ ] Avaliar CORS e configurações de segurança

## Tabela de mapeamento

| ID Achado | Categoria API | Severidade | Status |
|-----------|---------------|------------|--------|
| F-001 | API1 (BOLA) | Critical | Confirmado |
| | | | |
