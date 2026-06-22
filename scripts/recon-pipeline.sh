#!/usr/bin/env bash
#
# recon-pipeline.sh — Orquestra a fase de reconhecimento passivo + ativo leve.
#
# USO:
#   ./recon-pipeline.sh <dominio-alvo> [rate]
#
# ⚠️  SÓ EXECUTE CONTRA ALVOS AUTORIZADOS NO ESCOPO (specs/00-escopo.md).
#     Este script faz requests ativos (httpx, katana). Confirme autorização,
#     rate limit e janela de testes antes de rodar.
#
set -euo pipefail

# ─── Parâmetros ──────────────────────────────────────────────
TARGET="${1:-}"
RATE="${2:-30}"
OUTDIR="findings/recon"

if [[ -z "$TARGET" ]]; then
  echo "Uso: $0 <dominio-alvo> [rate]"
  exit 1
fi

# ─── Confirmação de escopo (trava de segurança) ──────────────
echo "═══════════════════════════════════════════════════════"
echo "  RECON PIPELINE — alvo: $TARGET (rate: $RATE req/s)"
echo "═══════════════════════════════════════════════════════"
echo
echo "⚠️  Confirme que '$TARGET' está autorizado em specs/00-escopo.md"
read -rp "    Digite 'SIM' para continuar: " confirm
[[ "$confirm" == "SIM" ]] || { echo "Abortado."; exit 1; }

mkdir -p "$OUTDIR"
cd "$OUTDIR"

check() { command -v "$1" >/dev/null 2>&1 || echo "  [!] $1 não encontrado — pulando etapa"; }

# ─── 1. Subdomínios (passivo) ────────────────────────────────
echo "[1/6] Enumerando subdomínios..."
check subfinder && subfinder -d "$TARGET" -all -silent > subs_subfinder.txt 2>/dev/null || true
check assetfinder && assetfinder --subs-only "$TARGET" 2>/dev/null | sort -u > subs_assetfinder.txt || true
cat subs_*.txt 2>/dev/null | sort -u > all_subs.txt || touch all_subs.txt
echo "      $(wc -l < all_subs.txt) subdomínios encontrados"

# ─── 2. Hosts vivos ──────────────────────────────────────────
echo "[2/6] Detectando hosts vivos..."
if command -v httpx >/dev/null 2>&1; then
  httpx -l all_subs.txt -silent -status-code -title -tech-detect \
        -rate-limit "$RATE" -o live_hosts.txt 2>/dev/null || true
  awk '{print $1}' live_hosts.txt 2>/dev/null | sort -u > live_urls.txt || touch live_urls.txt
else
  cp all_subs.txt live_urls.txt
fi
echo "      $(wc -l < live_urls.txt 2>/dev/null || echo 0) hosts vivos"

# ─── 3. URLs históricas (passivo) ────────────────────────────
echo "[3/6] Coletando URLs históricas..."
check gau && cat live_urls.txt | gau --threads 5 2>/dev/null > urls_gau.txt || true
check waybackurls && cat all_subs.txt | waybackurls 2>/dev/null > urls_wayback.txt || true
cat urls_*.txt 2>/dev/null | sort -u > all_urls.txt || touch all_urls.txt
grep -iE '\.js($|\?)' all_urls.txt 2>/dev/null | sort -u > js_urls.txt || touch js_urls.txt
grep -iE '\?' all_urls.txt 2>/dev/null | sort -u > urls_with_params.txt || touch urls_with_params.txt
echo "      $(wc -l < all_urls.txt) URLs / $(wc -l < js_urls.txt) arquivos JS"

# ─── 4. Crawling ativo ───────────────────────────────────────
echo "[4/6] Crawling ativo..."
if command -v katana >/dev/null 2>&1; then
  katana -list live_urls.txt -d 2 -jc -silent -rate-limit "$RATE" \
         2>/dev/null | sort -u > crawl_urls.txt || true
  grep -iE '\.js' crawl_urls.txt 2>/dev/null | sort -u >> js_urls.txt || true
  sort -u js_urls.txt -o js_urls.txt
fi
echo "      crawling concluído"

# ─── 5. DNS / dangling CNAME ─────────────────────────────────
echo "[5/6] Checando registros DNS e CNAMEs órfãos..."
if command -v dnsx >/dev/null 2>&1; then
  cat all_subs.txt | dnsx -silent -cname -resp 2>/dev/null | \
    grep -iE 'github\.io|herokuapp|s3\.amazonaws|azurewebsites|cloudfront|surge\.sh' \
    > dangling_cnames.txt || true
fi
echo "      $(wc -l < dangling_cnames.txt 2>/dev/null || echo 0) candidatos a takeover"

# ─── 6. Resumo ───────────────────────────────────────────────
echo "[6/6] Gerando resumo..."
cat > recon-summary.md << SUMMARY
# Resumo de Recon — $TARGET
Gerado em: $(date '+%Y-%m-%d %H:%M:%S')

## Inventário
- Subdomínios: $(wc -l < all_subs.txt)
- Hosts vivos: $(wc -l < live_urls.txt 2>/dev/null || echo 0)
- URLs (histórico + crawl): $(wc -l < all_urls.txt)
- Arquivos JS: $(wc -l < js_urls.txt)
- URLs com parâmetros: $(wc -l < urls_with_params.txt)
- Candidatos a takeover: $(wc -l < dangling_cnames.txt 2>/dev/null || echo 0)

## Próximos passos
- /jssecrets  → analisar js_urls.txt
- /ffuf       → fuzzing de conteúdo
- /params     → urls_with_params.txt
- /nuclei     → scan sobre live_urls.txt
- /takeover   → dangling_cnames.txt
SUMMARY

echo
echo "✅ Recon concluído. Resumo em $OUTDIR/recon-summary.md"
echo "   Lembre-se: scanners geram falsos positivos — valide tudo com /validate."
