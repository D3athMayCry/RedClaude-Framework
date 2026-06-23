# /headers — Cabeçalhos de Segurança e TLS

Avalia cabeçalhos HTTP de segurança e a configuração TLS/SSL.

## Ferramentas e uso

```bash
# Cabeçalhos de segurança (inspeção manual)
curl -sI https://alvo.com | grep -iE \
  'strict-transport|content-security|x-frame|x-content-type|referrer-policy|permissions-policy'

# Análise completa de TLS/SSL e cifras
testssl.sh --quiet --color 0 https://alvo.com > testssl_alvo.txt

# Em lote (httpx coleta alguns headers)
cat live_hosts.txt | httpx -silent -include-response -json -o headers_httpx.json
```

## O que verificar
| Cabeçalho ausente/fraco | Risco | OWASP |
|-------------------------|-------|-------|
| Strict-Transport-Security | Downgrade para HTTP | A05 |
| Content-Security-Policy | XSS facilitado | A05 |
| X-Frame-Options / frame-ancestors | Clickjacking | A05 |
| X-Content-Type-Options | MIME sniffing | A05 |
| TLS obsoleto / cifras fracas | Interceptação | A02 |

## Saída
- `findings/recon/testssl_alvo.txt` — relatório TLS
- `findings/recon/headers_httpx.json` — cabeçalhos coletados
- Achados de misconfiguration → `findings/F-XXX-*.md` (categoria A05/A02)

> Cabeçalhos ausentes costumam ser severidade Low/Info isolados, mas relevantes
> em conjunto. Classifique conforme `specs/reporting/cvss.md`.
