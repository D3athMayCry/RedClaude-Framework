# Arsenal de Ferramentas

> Referência central das ferramentas usadas pelos comandos em `.claude/commands/`.
> Todas são open source e padrão no mercado. Use **somente dentro do escopo** e
> respeitando `rate_limit` e `janela_de_testes` do `CLAUDE.md`.

## Instalação rápida (ProjectDiscovery + comuns)

```bash
# Suite ProjectDiscovery (recomendado: pdtm gerencia tudo)
go install github.com/projectdiscovery/pdtm/cmd/pdtm@latest
pdtm -ia   # instala subfinder, httpx, naabu, nuclei, katana, dnsx, etc.

# Descoberta de conteúdo / fuzzing
go install github.com/ffuf/ffuf/v2@latest

# URLs históricas
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/waybackurls@latest

# Subdomínios (complementares)
go install github.com/owasp-amass/amass/v4/...@master
go install github.com/tomnomnom/assetfinder@latest

# Segredos
# gitleaks: https://github.com/gitleaks/gitleaks/releases
# trufflehog: https://github.com/trufflesecurity/trufflehog/releases

# JS / parâmetros (Python)
pipx install arjun
# SecretFinder, LinkFinder, getJS — clonar dos repositórios oficiais

# GraphQL
# graphw00f, clairvoyance, InQL — clonar dos repositórios oficiais
pipx install clairvoyance

# Cloud
pip install cloud_enum
# aws-cli: https://aws.amazon.com/cli/

# Subdomain takeover
go install github.com/PentestPad/subzy@latest

# Wordlists
git clone https://github.com/danielmiessler/SecLists ~/wordlists/SecLists
```

## Tabela de referência

| Ferramenta | Categoria | Para que serve | Comando |
|------------|-----------|----------------|---------|
| subfinder | Recon | Enumeração passiva de subdomínios | `/subenum` |
| amass | Recon | Mapeamento de superfície (passivo/ativo) | `/subenum` |
| assetfinder | Recon | Subdomínios a partir de fontes públicas | `/subenum` |
| dnsx | Recon | Resolução e enumeração DNS em massa | `/dns` |
| httpx | Recon | Probe de hosts vivos, status, tech, títulos | `/httprobe` |
| naabu | Recon | Port scan rápido (SYN/CONNECT) | `/portscan` |
| nmap | Recon | Enumeração detalhada de portas/serviços | `/portscan` |
| katana | Recon | Crawler moderno (headless) | `/crawl` |
| gau / waybackurls | Recon | URLs históricas (Wayback, OTX, CommonCrawl) | `/wayback` |
| ffuf | Discovery | Fuzzing de diretórios, arquivos, vhosts, params | `/ffuf` |
| whatweb / wappalyzer | Discovery | Fingerprint de tecnologias | `/tech` |
| nuclei | Vuln scan | Scan baseado em templates da comunidade | `/nuclei` |
| testssl.sh | Vuln scan | Análise de TLS/SSL e cifras | `/headers` |
| arjun | Discovery | Descoberta de parâmetros HTTP ocultos | `/params` |
| paramspider | Discovery | Parâmetros a partir de URLs de arquivo | `/params` |
| LinkFinder / getJS | Secrets | Extrai endpoints de arquivos JS | `/jssecrets` |
| SecretFinder | Secrets | Procura chaves/segredos em JS | `/jssecrets` |
| gitleaks | Secrets | Detecta segredos em repositórios git | `/gitleaks` |
| trufflehog | Secrets | Segredos verificados em git/filesystem | `/gitleaks` |
| graphw00f | API | Fingerprint de engine GraphQL | `/graphql` |
| clairvoyance | API | Reconstrói schema GraphQL sem introspection | `/graphql` |
| cloud_enum | Cloud | Enumera buckets AWS/Azure/GCP | `/cloud` |
| subzy | Takeover | Detecta subdomain takeover por fingerprint | `/takeover` |

## Pipeline típico (Web/Bug Bounty)

```
/subenum  →  /httprobe  →  /dns  →  /wayback  →  /crawl  →  /jssecrets
                                ↓
          /ffuf  +  /params  +  /tech  +  /graphql  +  /cloud
                                ↓
            /nuclei  +  /headers  +  /cors  +  /takeover
                                ↓
              /validate  →  /chain  →  /report  →  /retest
```

Ou rode tudo de uma vez com os scripts:
```bash
./scripts/recon-pipeline.sh alvo.com 30   # fase de recon completa
./scripts/scan-pipeline.sh 30             # scan de vulnerabilidades
```

> O Claude deve encadear esses comandos respeitando a `profundidade`. Em
> `recon-only`/`passive`, rodar apenas as etapas de coleta (subenum, wayback,
> httprobe, jssecrets passivo). Scans ativos (ffuf, nuclei, portscan) exigem
> `profundidade: standard` ou superior.
