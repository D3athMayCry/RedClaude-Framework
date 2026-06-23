---
name: httprobe
description: "Probe de hosts vivos com httpx, coletando status, título, tecnologia e metadados. Use sempre após /subenum ou quando o usuário tiver lista de subdomínios para descobrir quais respondem. Tráfego HTTP leve — respeita rate limit do CLAUDE.md."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: active-recon
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Probe de Hosts Vivos

Identifica quais hosts/subdomínios respondem por HTTP/HTTPS e coleta metadados.

## Pré-checagem
- Use a lista de `findings/recon/all_subs.txt` (saída de `/subenum`).

## Ferramenta e uso

```bash
# httpx: detecta hosts vivos + status, título, tech, server, CDN
cat all_subs.txt | httpx -silent \
  -status-code -title -tech-detect -web-server -cdn \
  -follow-redirects -rate-limit 50 \
  -o live_hosts.txt

# Versão com JSON para parsing posterior
cat all_subs.txt | httpx -silent -json -o live_hosts.json
```

## Respeite o CONFIG
- Ajuste `-rate-limit` ao valor de `rate_limit` do escopo.
- Não rode fora da `janela_de_testes`.

## Saída
- `findings/recon/live_hosts.txt` — hosts vivos com metadados
- `findings/recon/live_hosts.json` — versão estruturada

Útil para priorizar: hosts com tech antiga, painéis de admin, status incomuns.
Próximos passos: `/wayback`, `/crawl`, `/tech`.
