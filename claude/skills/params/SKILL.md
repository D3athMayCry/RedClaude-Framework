---
name: params
description: "Descoberta de parâmetros HTTP ocultos com arjun e paramspider para ampliar a superfície de teste (entrada para IDOR, injeção, SSRF). Use quando o usuário pedir 'parâmetros escondidos', 'fuzz params', 'arjun' ou similar. Faz requests ao alvo — requer profundidade standard+."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: active-recon
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Descoberta de Parâmetros HTTP

Encontra parâmetros ocultos/não documentados que ampliam a superfície de teste
(entrada para testar IDOR, injeção, SSRF, etc.).

## Pré-checagem
- Alvos in-scope. Arjun faz requests ativos → `profundidade: standard`+.

## Ferramentas e uso

```bash
# arjun — descoberta ativa de parâmetros
arjun -u https://alvo.com/api/endpoint -m GET -oJ arjun_get.json
arjun -u https://alvo.com/api/endpoint -m POST -oJ arjun_post.json

# Em lote, a partir de URLs descobertas
arjun -i urls_with_params.txt -oJ arjun_bulk.json

# paramspider — parâmetros a partir de arquivos públicos (passivo)
paramspider -d alvo.com -o paramspider_out.txt

# Extrair parâmetros das URLs históricas (de /wayback)
cat all_urls.txt | grep -oP '(?<=[?&])[a-zA-Z0-9_]+(?==)' | sort -u > params_from_urls.txt
```

## Por que importa
Parâmetros ocultos costumam ter menos validação — terreno fértil para:
- IDOR/BOLA (parâmetros de ID)
- Injeção (parâmetros que tocam o banco)
- SSRF (parâmetros de URL/callback)
- Mass assignment (campos não documentados)

## Saída
- `findings/recon/params_*.json` / `.txt` — parâmetros descobertos
- Use como wordlist de entrada para `/ffuf` (fuzzing de valores) e `/validate`.
