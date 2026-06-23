# /wayback — URLs Históricas (Wayback Machine & Arquivos)

Coleta URLs já conhecidas dos alvos a partir de arquivos públicos (Wayback
Machine, Common Crawl, OTX, URLScan). Totalmente passivo — ótimo para achar
endpoints esquecidos, parâmetros e arquivos antigos.

## Pré-checagem
- Use os domínios/subdomínios in-scope.

## Ferramentas e uso

```bash
# gau — agrega Wayback + Common Crawl + OTX + URLScan
cat live_hosts.txt | gau --threads 5 > urls_gau.txt

# waybackurls — especificamente do Internet Archive
cat all_subs.txt | waybackurls > urls_wayback.txt

# Consolidar
cat urls_*.txt | sort -u > all_urls.txt

# Extrair pontos de interesse
grep -iE '\.js($|\?)' all_urls.txt | sort -u > js_urls.txt
grep -iE '\?' all_urls.txt | sort -u > urls_with_params.txt
grep -iE '\.(json|xml|config|bak|old|sql|env|log|txt)($|\?)' all_urls.txt > interesting_files.txt
```

## Por que é valioso
- Endpoints e parâmetros não visíveis no site atual
- Arquivos sensíveis que foram removidos mas estão no arquivo
- Versões antigas de API (mapeia para OWASP API9 — inventário)

## Saída
- `findings/recon/all_urls.txt` — todas as URLs históricas
- `findings/recon/js_urls.txt` — JS para analisar com `/jssecrets`
- `findings/recon/urls_with_params.txt` — entrada para `/params` e fuzzing
- `findings/recon/interesting_files.txt` — arquivos potencialmente sensíveis

> Confirmar exposição atual: uma URL no Wayback pode não existir mais. Valide
> antes de reportar, e só acesse o que está dentro do escopo.
