#!/usr/bin/env bash
#
# scan-pipeline.sh — Scan de vulnerabilidades sobre hosts já descobertos.
#
# USO:
#   ./scan-pipeline.sh [rate]
#
# Requer que recon-pipeline.sh tenha rodado antes (usa findings/recon/live_urls.txt).
#
# ⚠️  SCAN ATIVO. Só execute contra alvos autorizados, dentro da janela de
#     testes e do rate limit. Exclui templates de DoS por padrão.
#
set -euo pipefail

RATE="${1:-30}"
OUTDIR="findings/recon"
LIVE="$OUTDIR/live_urls.txt"

[[ -f "$LIVE" ]] || { echo "[!] $LIVE não existe. Rode recon-pipeline.sh primeiro."; exit 1; }

echo "⚠️  Scan ativo sobre $(wc -l < "$LIVE") hosts (rate: $RATE)."
read -rp "    Confirma que estão autorizados? Digite 'SIM': " confirm
[[ "$confirm" == "SIM" ]] || { echo "Abortado."; exit 1; }

cd "$OUTDIR"

# Nuclei — excluindo DoS/intrusivo
if command -v nuclei >/dev/null 2>&1; then
  echo "[1/2] Nuclei (CVE, exposure, misconfig, takeover)..."
  nuclei -l live_urls.txt \
    -severity low,medium,high,critical \
    -exclude-tags dos,intrusive,fuzz \
    -rate-limit "$RATE" -c 25 \
    -o nuclei_results.txt 2>/dev/null || true
  echo "      $(wc -l < nuclei_results.txt 2>/dev/null || echo 0) achados brutos"
else
  echo "  [!] nuclei não encontrado"
fi

# Subdomain takeover dedicado
if command -v subzy >/dev/null 2>&1 && [[ -f all_subs.txt ]]; then
  echo "[2/2] Verificando takeover..."
  subzy run --targets all_subs.txt --hide_fails 2>/dev/null > subzy_results.txt || true
fi

echo
echo "✅ Scan concluído. TODOS os achados precisam passar por /validate."
echo "   Nuclei e scanners geram falsos positivos — confirme manualmente."
