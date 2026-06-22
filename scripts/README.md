# scripts/ — Automação do Pipeline

Scripts que encadeiam os comandos/ferramentas para rodar fases inteiras de uma
vez. Este é o salto do template de "documentado" para "automatizado".

## ⚠️ Antes de rodar qualquer script
1. Preencha `specs/00-escopo.md` com a autorização e o IN-SCOPE.
2. Confirme `rate_limit` e `janela_de_testes` no `CLAUDE.md`.
3. Os scripts pedem confirmação explícita (`SIM`) antes de tocar no alvo.

## Scripts disponíveis

### `recon-pipeline.sh` — Reconhecimento completo
Encadeia: subdomínios → hosts vivos → URLs históricas → crawling → DNS/takeover
→ resumo. Em grande parte passivo, com crawling ativo leve.

```bash
./scripts/recon-pipeline.sh alvo.com 30
#                            ^alvo    ^rate (req/s)
```
Saída: `findings/recon/` + `recon-summary.md`.

### `scan-pipeline.sh` — Scan de vulnerabilidades
Roda Nuclei (excluindo DoS/intrusivo) e checagem de takeover sobre os hosts
descobertos. **Scan ativo** — requer autorização.

```bash
./scripts/scan-pipeline.sh 30
```
Saída: `findings/recon/nuclei_results.txt` etc. Tudo passa por `/validate`.

## Princípios de design
- **Trava de escopo:** todo script pede confirmação antes de agir.
- **Degradação graciosa:** se uma ferramenta não está instalada, pula a etapa
  em vez de quebrar.
- **Rate limit respeitado:** o rate é parâmetro, repassado a cada ferramenta.
- **Sem DoS:** o scan exclui templates intrusivos por padrão.
- **Saída padronizada:** tudo cai em `findings/recon/` para as próximas fases.

## Ferramentas necessárias
Veja `specs/tooling.md` para instalação. Os scripts detectam o que está
disponível; instale ao menos: subfinder, httpx, gau, katana, dnsx, nuclei.

## Estendendo
Crie novos scripts seguindo o padrão: confirmação de escopo no início, rate como
parâmetro, degradação graciosa, saída em `findings/`. Ideias: `api-pipeline.sh`
(focado em descoberta de endpoints de API), `secrets-pipeline.sh` (jssecrets +
gitleaks combinados).
