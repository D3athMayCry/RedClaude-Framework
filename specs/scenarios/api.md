# Profile — API (REST / GraphQL)

> Ativado por `cenario: [api]`. Combine com OWASP API Top 10 + WSTG-APIT.

## Superfície de ataque
Endpoints REST/GraphQL, autenticação (tokens, JWT, OAuth, API keys), objetos e
suas propriedades, versões antigas, documentação (OpenAPI/Swagger), webhooks.

## Fluxo por fase

### Recon
- Descobrir endpoints: documentação, especificação OpenAPI, JS de SPA, app mobile,
  tráfego capturado
- Identificar esquema de autenticação e versões expostas (/v1, /v2, /internal)
- Mapear inventário completo (API9 — shadow/zombie APIs)

### Modelagem de ameaças
- Mapear quais objetos pertencem a quais usuários (base para testes BOLA)
- Identificar funções privilegiadas (base para BFLA)
- Mapear fluxos de negócio sensíveis

### Enumeração & Análise
- Percorrer o checklist de `methodologies/owasp-api-top10.md`
- Foco em BOLA (API1), autenticação (API2), property-level authz (API3)

### Validação
- Confirmar acesso indevido com duas contas de teste distintas
- Documentar request/response (mascarando dados sensíveis)

## Vetores prioritários
1. BOLA — troca de IDs de objeto entre usuários
2. Broken Authentication — análise de JWT e tokens
3. BFLA — acesso a funções administrativas
4. Excessive data exposure / mass assignment
5. Resource consumption (rate limiting)
6. SSRF e misconfiguration

## Notas técnicas
- Para JWT: validar assinatura, testar `alg: none`, conferir expiração e claims
- Para GraphQL: introspection, batching, profundidade de query, aliases
- Sempre use as credenciais de teste fornecidas no escopo — nunca contas reais
