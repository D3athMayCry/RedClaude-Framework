# /crawl — Crawling / Spidering

Mapeia ativamente a estrutura da aplicação, descobrindo links, endpoints,
formulários e arquivos JS.

## Pré-checagem
- Alvos vivos de `findings/recon/live_hosts.txt`.
- Crawling é ativo: requer `profundidade: standard` ou superior.

## Ferramenta e uso

```bash
# katana — crawler moderno com suporte a JS/headless
katana -u https://alvo.com -d 3 \
  -jc -kf all -aff \
  -rate-limit 20 \
  -o crawl_urls.txt

# Coletar especificamente endpoints em JS
katana -u https://alvo.com -d 3 -jc -silent | grep -iE '\.js' | sort -u > crawl_js.txt
```

Flags: `-d` profundidade, `-jc` parse de JavaScript, `-kf all` formulários
conhecidos, `-aff` campos de formulário automáticos.

## Respeite o CONFIG
- Ajuste `-rate-limit` ao escopo.
- Não saia do domínio autorizado (katana respeita escopo por padrão; confirme).

## Saída
- `findings/recon/crawl_urls.txt` — URLs descobertas ativamente
- `findings/recon/crawl_js.txt` — JS encontrados (→ `/jssecrets`)

Combine com a saída de `/wayback` para cobertura máxima.
