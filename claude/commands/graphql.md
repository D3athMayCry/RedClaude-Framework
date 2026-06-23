# /graphql — Testes de GraphQL

Avalia endpoints GraphQL: introspection, exposição de schema, autorização por
campo (BOLA/BFLA), batching e profundidade de query.

## Pré-checagem
- Endpoint GraphQL in-scope (comum: `/graphql`, `/api/graphql`, `/v1/graphql`, `/query`).
- Use credenciais de teste fornecidas no escopo.

## Ferramentas e uso

```bash
# Localizar endpoints GraphQL
cat all_urls.txt | grep -iE 'graphql|/query|/gql' | sort -u > graphql_endpoints.txt

# 1. Testar se introspection está habilitada (revela todo o schema)
curl -s https://alvo.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{__schema{types{name fields{name}}}}"}' | jq .

# 2. Ferramentas dedicadas
# graphw00f — fingerprint do engine GraphQL
python3 graphw00f.py -d -f -t https://alvo.com/graphql

# clairvoyance — reconstrói schema mesmo com introspection desabilitada
clairvoyance https://alvo.com/graphql -o schema.json

# InQL / GraphQL Voyager — visualização do schema (uso manual)
```

## O que testar
| Teste | Risco | OWASP API |
|-------|-------|-----------|
| Introspection habilitada em produção | Vazamento de schema | API8 |
| Acesso a objetos de outros usuários por query | BOLA | API1 |
| Queries/mutations administrativas acessíveis | BFLA | API5 |
| Ausência de limite de profundidade/complexidade | DoS por query aninhada | API4 |
| Batching de queries sem rate limit | Brute force/abuso | API4/API6 |
| Campos sensíveis expostos na resposta | Excessive data exposure | API3 |

## Notas técnicas
- **Introspection:** se `__schema` retornar o schema, documente como exposição
  (API8). Muitos programas aceitam isso como Low/Info isolado.
- **Profundidade:** teste queries aninhadas, mas **sem** derrubar o serviço.
  Não envie payloads de profundidade extrema contra produção (vira DoS).
- **BOLA em GraphQL:** troque IDs em queries entre duas contas de teste.
- **Batching:** alguns endpoints aceitam array de queries — teste se contorna
  rate limiting, sem abusar.

## Saída
- `findings/recon/graphql_endpoints.txt` + `schema.json`
- Achados confirmados → `findings/F-XXX-graphql.md`, mapeados ao OWASP API Top 10.

> Não teste profundidade/complexidade de forma destrutiva em produção. Prove o
> conceito com payloads moderados e respeite a janela de testes.
