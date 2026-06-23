# /recon — Fase de Reconhecimento (Orquestrador)

Executa a fase de reconhecimento (PTES: Intelligence Gathering) encadeando os
comandos de coleta especializados.

## Antes de executar
1. Confirme que `specs/00-escopo.md` está preenchido e autorizado.
2. Leia o CONFIG no `CLAUDE.md`: `cenario`, `abordagem`, `profundidade`.
3. Carregue o profile em `specs/scenarios/<cenario>.md` e `specs/tooling.md`.

## Orquestração por profundidade

### recon-only / passive (somente passivo)
Encadeie apenas:
```
/subenum  →  /httprobe  →  /dns  →  /wayback  →  /tech  →  /jssecrets (análise estática)
```

### standard ou superior (passivo + ativo leve)
Adicione coleta ativa:
```
/subenum → /httprobe → /dns → /wayback → /crawl → /tech
        → /ffuf → /params → /jssecrets → /portscan (se cenário network)
```

## O que consolidar
Ao final, agregue tudo em `findings/recon-summary.md`:
- Inventário de ativos in-scope (subdomínios vivos, IPs, portas)
- Tecnologias e versões identificadas
- URLs, endpoints e parâmetros descobertos
- Arquivos e segredos suspeitos para investigar
- Pontos de maior interesse para `/threat-model` e `/enum`

## Regras
- Só descubra/registre ativos dentro do IN-SCOPE. Descarte o resto.
- Respeite `rate_limit` e `janela_de_testes` em todos os comandos.
- **Não** inicie validação de vulnerabilidades aqui — isso é `/enum` e `/validate`.

## Saída
- `findings/recon/` — outputs brutos de cada ferramenta
- `findings/recon-summary.md` — síntese para as próximas fases
