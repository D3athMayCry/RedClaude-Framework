---
name: dns
description: "Enumeração e resolução DNS com dnsx e dig. Detecta dangling CNAMEs (candidatos a subdomain takeover). Use quando o usuário pedir 'DNS', 'resolva subdomínios', 'detecte takeover potencial' ou similar. Consulta DNS — sem tráfego HTTP ao alvo."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: passive-recon
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Enumeração e Resolução DNS

Resolve subdomínios e coleta registros DNS dos alvos in-scope.

## Ferramentas e uso

```bash
# dnsx — resolução em massa + tipos de registro
cat all_subs.txt | dnsx -silent -a -aaaa -cname -resp -o dns_records.txt

# Detectar possíveis subdomain takeovers (CNAMEs órfãos)
cat all_subs.txt | dnsx -silent -cname -resp | grep -iE 'github.io|herokuapp|s3.amazonaws|azurewebsites|cloudfront' > dangling_cnames.txt

# Registros gerais de um domínio
dig alvo.com ANY +noall +answer
dig alvo.com TXT +short    # SPF, DKIM, verificações
```

## Por que importa
- CNAMEs apontando para serviços não reclamados → subdomain takeover (alto impacto)
- Registros TXT podem revelar serviços de terceiros usados
- Resolução confirma quais subdomínios realmente existem

## Saída
- `findings/recon/dns_records.txt` — registros resolvidos
- `findings/recon/dangling_cnames.txt` — candidatos a takeover (→ `/validate`)

> Subdomain takeover só deve ser confirmado de forma não-destrutiva e dentro do
> escopo. Não reivindique recursos de terceiros sem autorização.
