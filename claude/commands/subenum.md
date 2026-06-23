# /subenum — Enumeração de Subdomínios

Descobre subdomínios dos domínios-raiz autorizados no escopo.

## Pré-checagem
- Confirme os domínios-raiz em `specs/00-escopo.md` (IN-SCOPE).
- Só enumere domínios autorizados. Descarte qualquer resultado fora do escopo.

## Ferramentas e uso

```bash
# Passivo (sempre permitido) — combinando várias fontes
subfinder -d alvo.com -all -silent -o subs_subfinder.txt
assetfinder --subs-only alvo.com | sort -u > subs_assetfinder.txt
amass enum -passive -d alvo.com -o subs_amass.txt

# Consolidar e deduplicar
cat subs_*.txt | sort -u > all_subs.txt

# Ativo (somente profundidade standard+, respeitando rate limit)
# amass enum -active -d alvo.com -o subs_active.txt
```

## Profundidade
- `recon-only` / `passive` → apenas fontes passivas (subfinder, assetfinder, amass -passive)
- `standard`+ → permite brute force/active enum com rate limit

## Saída
- `findings/recon/all_subs.txt` — lista consolidada (apenas in-scope)
- Filtre contra o escopo: remova subdomínios que não pertençam aos alvos autorizados.

Próximo passo: `/httprobe` para descobrir quais estão vivos.
