# /ffuf — Fuzzing de Conteúdo e Parâmetros

Descoberta ativa de diretórios, arquivos, vhosts e parâmetros via FFUF.

## Pré-checagem
- Alvo in-scope. Fuzzing é ativo → requer `profundidade: standard`+.
- **Ajuste o rate** ao `rate_limit` do escopo (flag `-rate` ou `-p` delay).

## Usos principais

```bash
WL=~/wordlists/SecLists

# 1. Diretórios e arquivos
ffuf -u https://alvo.com/FUZZ \
  -w $WL/Discovery/Web-Content/raft-medium-directories.txt \
  -mc 200,204,301,302,307,401,403 \
  -rate 30 -t 20 -o ffuf_dirs.json

# 2. Arquivos por extensão
ffuf -u https://alvo.com/FUZZ \
  -w $WL/Discovery/Web-Content/raft-medium-files.txt \
  -e .php,.bak,.old,.zip,.txt,.json,.config \
  -mc 200,403 -rate 30 -o ffuf_files.json

# 3. Virtual hosts (descobre apps escondidos no mesmo IP)
ffuf -u https://alvo.com/ -H "Host: FUZZ.alvo.com" \
  -w $WL/Discovery/DNS/subdomains-top1million-5000.txt \
  -fs 0 -rate 30 -o ffuf_vhost.json

# 4. Fuzzing de parâmetros GET
ffuf -u "https://alvo.com/page?FUZZ=test" \
  -w $WL/Discovery/Web-Content/burp-parameter-names.txt \
  -mc all -fs <tamanho_resposta_padrao> -rate 30 -o ffuf_params.json

# 5. Fuzzing de valores (ex: IDs para testar IDOR/BOLA)
ffuf -u "https://alvo.com/api/user/FUZZ" \
  -w ids.txt -mc 200 -rate 20 -o ffuf_ids.json
```

## Dicas de filtragem
- `-mc` filtra por status code; `-fs` filtra por tamanho; `-fw` por palavras.
- Calibre os filtros para reduzir falsos positivos (compare com uma resposta 404 base).
- Use `-recursion -recursion-depth 2` com cuidado (aumenta volume de requests).

## Saída
- `findings/recon/ffuf_*.json` — resultados por tipo
- Descobertas de admin/backup/config → priorizar em `/validate`.

> Fuzzing gera muito tráfego. Em produção, mantenha rate baixo e respeite a janela.
