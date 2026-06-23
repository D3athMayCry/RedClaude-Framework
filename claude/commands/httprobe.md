# /httprobe — Probe de Hosts Vivos

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
