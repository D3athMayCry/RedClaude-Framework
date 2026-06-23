# /jssecrets — Segredos e Endpoints em JavaScript

Analisa arquivos JavaScript em busca de segredos expostos (chaves de API, tokens)
e endpoints internos. Uma das fontes de maior impacto em bug bounty.

## Pré-checagem
- Lista de JS de `/wayback` (`js_urls.txt`) e `/crawl` (`crawl_js.txt`).
- Apenas JS de alvos in-scope.

## Ferramentas e uso

```bash
# Consolidar todos os JS encontrados
cat js_urls.txt crawl_js.txt | sort -u > all_js.txt

# Baixar os arquivos JS localmente para análise
mkdir -p js_files
while read url; do
  fname=$(echo "$url" | md5sum | cut -d' ' -f1)
  curl -s "$url" -o "js_files/$fname.js"
done < all_js.txt

# 1. Extrair endpoints/rotas com LinkFinder
python3 linkfinder.py -i 'js_files/*.js' -o cli > js_endpoints.txt

# 2. Procurar segredos com SecretFinder
for f in js_files/*.js; do
  python3 SecretFinder.py -i "$f" -o cli
done > js_secrets.txt

# 3. Grep manual por padrões comuns de segredos
grep -rEi '(api[_-]?key|secret|token|password|aws_access|bearer|authorization)["'\'' :=]+[A-Za-z0-9/_\-]{16,}' js_files/ > js_grep_secrets.txt

# 4. Padrões de chaves conhecidas
grep -rEoi 'AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_\-]{35}|sk_live_[0-9a-zA-Z]{24}|ghp_[0-9a-zA-Z]{36}' js_files/ > js_known_keys.txt
```

## O que procurar
- Chaves de API (AWS `AKIA...`, Google `AIza...`, Stripe `sk_live_...`, GitHub `ghp_...`)
- Tokens JWT/bearer hardcoded
- Endpoints internos/admin não linkados na navegação
- URLs de API e versões antigas (→ OWASP API9)
- Credenciais de serviços de terceiros

## Validação crítica
- Uma chave encontrada **pode estar revogada ou ser de baixo privilégio**.
- **Não use a chave para acessar recursos** além de uma verificação mínima e
  não-destrutiva que confirme a validade. Em bug bounty, reportar a exposição
  costuma bastar — não pivote para acesso indevido a dados.
- Mascare a chave no relatório (mostre só os primeiros caracteres).

## Saída
- `findings/recon/js_endpoints.txt` — novos endpoints (→ `/params`, `/validate`)
- `findings/recon/js_secrets.txt` + `js_known_keys.txt` — segredos suspeitos
- Segredos confirmados → `findings/F-XXX-*.md` (A02/A05), chave mascarada.

> Segredo exposto é achado de alto valor. Prove a exposição, não o abuso.
