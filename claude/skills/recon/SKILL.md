---
name: recon
description: "Orquestra a fase completa de reconhecimento (PTES Intelligence Gathering) para um alvo de pentest ou bug bounty autorizado. Use SEMPRE que o usuário pedir para começar a reconhecer, mapear, enumerar ou explorar a superfície de ataque de um alvo — encadeia subenum, httprobe, dns, wayback, crawl, tech e jssecrets respeitando a profundidade configurada no CLAUDE.md. Acione mesmo quando o usuário disser apenas 'comece o recon de X' ou 'descubra o que tem em Y'."
disable-model-invocation: false
allowed-tools: Read, Write, Bash, Grep, Glob
metadata:
  version: "1.0"
  category: phase
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Fase de Reconhecimento (Orquestrador)

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
