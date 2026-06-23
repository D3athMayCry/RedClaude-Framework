---
name: cloud
description: "Procura buckets de nuvem expostos (AWS S3, GCP, Azure Blob) associados ao alvo usando cloud_enum. Use quando o usuário pedir 'buckets', 'S3', 'cloud enum', 'storage exposto' ou similar. IMPORTANTE: confirme propriedade do bucket antes de reportar; prove a má configuração sem exfiltrar dados reais."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: active-offensive
  requires-explicit-confirmation: "true"
  framework: offensive-security-template
---

# Recursos de Nuvem Expostos

Procura buckets de armazenamento e recursos de nuvem mal configurados (AWS S3,
Google Cloud Storage, Azure Blob) associados ao alvo.

## Pré-checagem
- **Só teste recursos que pertençam à organização in-scope.** Buckets de
  terceiros estão fora. Confirme a propriedade antes de reportar.
- Acesso a dados em buckets pode envolver PII — colete o mínimo necessário.

## Ferramentas e uso

```bash
# Coletar nomes candidatos (do nome da org, subdomínios, JS)
# Ex.: empresa, empresa-prod, empresa-backup, empresa-assets

# 1. cloud_enum — enumera AWS, Azure e GCP de uma vez
cloud_enum -k empresa -k empresa-prod -k empresa-dev -l cloud_results.txt

# 2. S3 — verificar bucket específico (somente in-scope)
aws s3 ls s3://bucket-do-alvo --no-sign-request    # acesso anônimo de listagem
curl -s https://bucket-do-alvo.s3.amazonaws.com/   # listagem via HTTP

# 3. Azure Blob
curl -s "https://conta.blob.core.windows.net/container?restype=container&comp=list"

# 4. GCP Storage
curl -s "https://storage.googleapis.com/bucket-do-alvo/"

# Referências em JS/HTML que vazam nomes de bucket
grep -rEoi 's3[.-][a-z0-9.-]*amazonaws\.com|[a-z0-9.-]+\.blob\.core\.windows\.net|storage\.googleapis\.com/[a-z0-9._-]+' js_files/ all_urls.txt | sort -u > cloud_refs.txt
```

## Configurações inseguras a procurar
- Bucket com **listagem pública** habilitada
- Bucket com **leitura pública** de objetos sensíveis
- Bucket com **escrita pública** (crítico — permite upload por qualquer um)
- Credenciais de nuvem vazadas em JS/git (cruze com `/jssecrets` e `/gitleaks`)

## Impacto e mapeamento
- Listagem/leitura pública → exposição de dados (A01/A05)
- Escrita pública → comprometimento de integridade (alto/crítico)

## Validação responsável
- Para provar leitura pública: liste e acesse **um** objeto não-sensível, ou
  confirme o cabeçalho sem baixar PII.
- Para escrita pública: faça upload de **um arquivo de teste inócuo** (ex.:
  `poc-<seu-handle>.txt`) e **remova-o** depois, se possível, documentando.
- **Nunca** baixe ou exfiltre dados reais de usuários além do mínimo de prova.

## Saída
- `findings/recon/cloud_results.txt`, `cloud_refs.txt`
- Achados confirmados → `findings/F-XXX-cloud.md` (mascarando qualquer dado sensível).

> Propriedade é essencial: confirme que o recurso é do alvo antes de reportar.
> Prove a má configuração, não o acesso a dados reais.
