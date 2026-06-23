# /takeover — Confirmação de Subdomain Takeover

Confirma, de forma não-destrutiva, subdomínios vulneráveis a takeover (CNAME
apontando para um serviço não reclamado).

## Pré-checagem
- Use os candidatos de `/dns` (`dangling_cnames.txt`).
- Subdomínios in-scope apenas.

## Ferramentas e uso

```bash
# 1. Detecção automatizada com fingerprints conhecidos
subzy run --targets all_subs.txt --output subzy_results.json
nuclei -l all_subs.txt -tags takeover -o nuclei_takeover.txt

# 2. Verificação manual do CNAME
dig cname sub.alvo.com +short
# Se aponta para um serviço (github.io, herokuapp, s3, azurewebsites...)
# e o recurso não existe mais → candidato a takeover

# 3. Confirmar o estado do serviço alvo (sem reclamar o recurso)
curl -sI https://sub.alvo.com
# Mensagens como "There isn't a GitHub Pages site here" ou
# "NoSuchBucket" indicam recurso não reclamado
```

## Serviços comumente vulneráveis
GitHub Pages, Heroku, AWS S3, Azure (cloudapp/azurewebsites), Shopify, Fastly,
Surge, Tumblr, Zendesk, e outros. Cada um tem uma assinatura de "não reclamado".

## Validação responsável — IMPORTANTE
- **Confirme apenas a vulnerabilidade**, não execute o takeover de fato.
- A prova aceita é: o CNAME aponta para o serviço + o serviço retorna a mensagem
  de "recurso não existe" + o serviço permitiria reivindicação.
- **Não reivindique o recurso** (não crie o repo/app/bucket) a menos que o
  programa **explicitamente** peça PoC desse tipo. Reivindicar pode causar
  indisponibilidade ou ser considerado fora do escopo.
- Se precisar de PoC mais forte e for autorizado, hospede apenas um arquivo
  inócuo identificando você como pesquisador, e libere o recurso depois.

## Impacto
Takeover permite servir conteúdo malicioso sob o domínio legítimo (phishing,
roubo de cookies, bypass de CORS/CSP). Geralmente High/Critical.

## Saída
- `findings/recon/subzy_results.json`, `nuclei_takeover.txt`
- Confirmados → `findings/F-XXX-takeover.md` com o CNAME, o serviço e a evidência
  da mensagem de "não reclamado".

> Confirme a vulnerabilidade sem executá-la. Reivindicar recursos de terceiros
> pode ser ilegal ou fora do escopo — só com autorização explícita.
