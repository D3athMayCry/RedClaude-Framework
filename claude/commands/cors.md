# /cors — Teste de Configuração CORS

Verifica configurações inseguras de Cross-Origin Resource Sharing.

## Pré-checagem
- Endpoints in-scope (de `/crawl`, `/wayback`, `/httprobe`).

## Uso

```bash
# Testar reflexão de Origin arbitrária
curl -sI https://alvo.com/api/data \
  -H "Origin: https://evil-attacker.example" | grep -i 'access-control'

# Se refletir a origin + Allow-Credentials: true → vulnerável
# Testar variações:
for origin in "https://evil.example" "null" "https://alvo.com.evil.example"; do
  echo "[Origin: $origin]"
  curl -sI https://alvo.com/api/data -H "Origin: $origin" | grep -i 'access-control'
done
```

## Configurações inseguras a procurar
- `Access-Control-Allow-Origin` reflete qualquer origin enviada
- `Allow-Origin: *` **junto com** `Allow-Credentials: true`
- Aceita `null` como origin
- Regex de validação contornável (`alvo.com.evil.com`)

## Impacto
Origin arbitrária + credenciais → roubo de dados autenticados de usuários.
Mapeia para A05 (misconfiguration) / API8.

## Saída
- Achados confirmados → `findings/F-XXX-cors.md` com a origin testada e a resposta
  vulnerável (mascarando dados sensíveis).

> Use uma origin de atacante fictícia (`evil-attacker.example`). Não exfiltre
> dados reais — prove o conceito com uma conta de teste.
