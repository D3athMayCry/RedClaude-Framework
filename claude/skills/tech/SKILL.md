---
name: tech
description: "Fingerprint de tecnologias (servidor, framework, CMS, versões) usando whatweb e httpx. Use quando o usuário pedir 'qual tecnologia', 'fingerprint', 'que stack roda', 'detecte versões' ou similar. Faz requests leves ao alvo — respeita rate limit."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: passive-recon
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Fingerprint de Tecnologias

Identifica tecnologias, frameworks, CMS, servidores e versões dos alvos.

## Ferramentas e uso

```bash
# whatweb — fingerprint rápido e detalhado
whatweb -a 3 https://alvo.com

# Em lote sobre hosts vivos
whatweb -a 3 -i live_hosts.txt --log-json=tech_whatweb.json

# httpx também faz tech-detect (já coletado em /httprobe)
cat live_hosts.txt | httpx -silent -tech-detect -json -o tech_httpx.json
```

## Por que importa
- Versões identificadas → cruzar com CVEs conhecidos (OWASP A06 — componentes desatualizados)
- Stack tecnológico orienta os testes (ex: se é WordPress, focar em plugins)
- Revela WAF/CDN que afetam a estratégia de testes

## Saída
- `findings/recon/tech_*.json` — tecnologias por host
- Versões antigas/vulneráveis → `/nuclei` (templates de CVE) e `/validate`

Use para direcionar `/nuclei` e a enumeração com templates específicos da stack.
