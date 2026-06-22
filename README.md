# 🛡️ Offensive Security Template — Framework Modular para Claude Code

Template global, modular e adaptável para conduzir operações de segurança
ofensiva **autorizadas** com o Claude Code. Funciona para Web, API, Mobile,
Network, Red Team, Bug Bounty e pentest corporativo.

> 📖 **Novo por aqui? Comece pelo [GUIA-DE-USO.md](GUIA-DE-USO.md)** — documentação
> completa com início rápido, referência de comandos e um exemplo prático do começo ao fim.

## Como funciona

O `CLAUDE.md` na raiz é o cérebro. Você edita o bloco `CONFIG` dele para cada
engajamento (tipo de alvo, abordagem, profundidade, metodologias). O Claude Code
lê isso automaticamente e ativa apenas os módulos relevantes:

- **`specs/scenarios/`** — perfis por tipo de alvo. Cada um define a superfície,
  ferramentas típicas e checklist específico.
- **`specs/methodologies/`** — referência das metodologias (WSTG, PTES, OSSTMM,
  OWASP Top 10, API Top 10). Ative/desative no CONFIG.
- **`.claude/commands/`** — comandos reutilizáveis (`/recon`, `/enum`, etc.) que
  orquestram cada fase.
- **`findings/`** — um arquivo por vulnerabilidade, padronizado.
- **`specs/reporting/`** — guia de CVSS e modelo de relatório final.

## Início rápido

```bash
# 1. Copie o template para o seu projeto
cp -r offensive-security-template meu-engajamento
cd meu-engajamento

# 2. Preencha a autorização e o escopo (OBRIGATÓRIO)
$EDITOR specs/00-escopo.md

# 3. Ajuste o CONFIG no CLAUDE.md (cenário, abordagem, profundidade)
$EDITOR CLAUDE.md

# 4. Abra o Claude Code na pasta
claude

# 5. Rode as fases
/recon
/threat-model
/enum
/validate
/report
```

## Filosofia de design

- **Modular** — cada seção é independente; ative só o que precisa.
- **Seguro por padrão** — `profundidade: standard` não explora ativamente.
  Você precisa elevar conscientemente para `deep`/`full`.
- **Rastreável** — tudo vira artefato em `findings/` e `evidence/`.
- **Prático** — checklists acionáveis, não teoria solta.
- **Automatável** — estrutura pronta para evoluir com scripts em `scripts/`.

# 📖 Guia de Uso — Offensive Security Template

Documentação completa para usar este template de segurança ofensiva com o
**Claude Code**. Do zero ao primeiro relatório.

> ⚠️ **Antes de tudo:** este template é para **testes autorizados** — pentest com
> contrato, bug bounty dentro do escopo de um programa, ou laboratórios próprios.
> Testar sistemas sem autorização é crime (no Brasil, Lei 12.737/2012 e Marco
> Civil da Internet). Nunca rode nada contra um alvo sem autorização por escrito.

---

## 📑 Índice

1. [O que é este template](#1-o-que-é-este-template)
2. [Pré-requisitos](#2-pré-requisitos)
3. [Início rápido (5 minutos)](#3-início-rápido-5-minutos)
4. [Como o Claude Code carrega o template](#4-como-o-claude-code-carrega-o-template)
5. [Configuração detalhada (o CONFIG)](#5-configuração-detalhada-o-config)
6. [O fluxo de trabalho](#6-o-fluxo-de-trabalho)
7. [Referência de comandos](#7-referência-de-comandos)
8. [Scripts de automação](#8-scripts-de-automação)
9. [Metodologias: quando ativar cada uma](#9-metodologias-quando-ativar-cada-uma)
10. [Cenários: qual perfil para qual alvo](#10-cenários-qual-perfil-para-qual-alvo)
11. [Gerando o relatório](#11-gerando-o-relatório)
12. [Modelo de segurança e uso responsável](#12-modelo-de-segurança-e-uso-responsável)
13. [Exemplo prático completo](#13-exemplo-prático-completo)
14. [Solução de problemas (FAQ)](#14-solução-de-problemas-faq)
15. [Estendendo o template](#15-estendendo-o-template)

---

## 1. O que é este template

Um **framework modular** que transforma o Claude Code num assistente de segurança
ofensiva estruturado. Em vez de digitar instruções soltas a cada sessão, você
define uma vez (no `CLAUDE.md`) quem é o engajamento, qual o escopo e quais as
regras — e o Claude Code passa a operar de forma consistente, rastreável e
alinhada a metodologias reconhecidas.

**Funciona para:** Web, API, Mobile, Network, Red Team, Bug Bounty e pentest
corporativo completo.

**Inclui:**
- Config central configurável (`CLAUDE.md`)
- 5 metodologias (WSTG, PTES, OSSTMM, OWASP Web Top 10, OWASP API Top 10)
- 7 perfis de cenário
- 24 comandos cobrindo recon → exploração → relatório → reteste
- 2 scripts de automação de pipeline
- Modelo de relatório com classificação CVSS

---

## 2. Pré-requisitos

### Claude Code
Instale via npm (requer Node.js):
```bash
npm install -g @anthropic-ai/claude-code
```
Documentação oficial: https://docs.claude.com/en/docs/claude-code/overview

### Ferramentas de segurança
Os comandos orquestram ferramentas open source padrão. Veja a lista completa e
os comandos de instalação em [`specs/tooling.md`](specs/tooling.md). O essencial:

```bash
# Suite ProjectDiscovery (gerencia a maioria de uma vez)
go install github.com/projectdiscovery/pdtm/cmd/pdtm@latest
pdtm -ia   # instala subfinder, httpx, naabu, nuclei, katana, dnsx...

# Fuzzing e URLs históricas
go install github.com/ffuf/ffuf/v2@latest
go install github.com/lc/gau/v2/cmd/gau@latest

# Wordlists
git clone https://github.com/danielmiessler/SecLists ~/wordlists/SecLists
```

> Os scripts de automação detectam o que está instalado e pulam etapas de
> ferramentas ausentes — então você pode começar com um subconjunto.

---

## 3. Início rápido (5 minutos)

```bash
# 1. Copie o template para a pasta do seu engajamento
cp -r offensive-security-template meu-bb-empresa
cd meu-bb-empresa

# 2. Preencha a autorização e o escopo (OBRIGATÓRIO)
$EDITOR specs/00-escopo.md

# 3. Ajuste o CONFIG no CLAUDE.md (cenário, abordagem, profundidade)
$EDITOR CLAUDE.md

# 4. Abra o Claude Code — ele lê o CLAUDE.md automaticamente
claude

# 5. Confirme que carregou
#    Dentro do Claude Code, digite:
/memory
#    Ou pergunte: "qual é o meu escopo e cenário configurado?"

# 6. Comece
/recon
```

Pronto — daí em diante é seguir o [fluxo de trabalho](#6-o-fluxo-de-trabalho).

---

## 4. Como o Claude Code carrega o template

Entender isto é o que faz o template funcionar de verdade. São **três camadas**,
cada uma carregada de um jeito diferente:

### Camada 1 — `CLAUDE.md` (raiz): carrega sozinho
O Claude Code carrega os arquivos de memória **automaticamente** ao iniciar a
sessão, subindo pela árvore de diretórios a partir da pasta atual. Então o
`CONFIG` e as regras inegociáveis já entram no contexto sem você fazer nada.

### Camada 2 — `specs/`: carregam sob demanda
Os arquivos em `specs/` **não** entram sozinhos. O Claude Code os lê quando:
- um **comando** aponta para eles (ex: `/recon` diz "carregue `specs/scenarios/web.md`"), ou
- você usa **import** com a sintaxe `@caminho/arquivo` dentro do `CLAUDE.md`.

> 💡 **Dica:** se quiser forçar um spec a carregar toda sessão, adicione um import
> no fim do `CLAUDE.md`, por exemplo: `@specs/scenarios/web.md`

### Camada 3 — `.claude/commands/`: viram comandos `/`
Cada arquivo `.md` aqui vira um comando slash — o nome do arquivo (sem `.md`) é o
nome do comando. Assim `recon.md` → `/recon`, `nuclei.md` → `/nuclei`.

```
┌─────────────────────────────────────────────────────────┐
│  Você abre o Claude Code na pasta do engajamento         │
└───────────────────────────┬─────────────────────────────┘
                            │
          ┌─────────────────┼──────────────────┐
          ▼                 ▼                  ▼
   ┌────────────┐   ┌──────────────┐   ┌─────────────────┐
   │ CLAUDE.md  │   │   specs/     │   │ .claude/commands│
   │ AUTOMÁTICO │   │ SOB DEMANDA  │   │  viram  /comando│
   │ (sempre)   │   │ (quando lido)│   │  (você invoca)  │
   └────────────┘   └──────────────┘   └─────────────────┘
```

### Nota sobre versões do Claude Code
A partir da v2.1.101 (abril/2026), os comandos slash customizados foram fundidos
com **skills**. Os arquivos em `.claude/commands/` **continuam funcionando sem
alteração**. O formato mais novo é `.claude/skills/<nome>/SKILL.md`, que permite
invocação por `/nome` **e** invocação autônoma pelo Claude.

**Para segurança ofensiva, manter `.claude/commands/` é uma vantagem:** você quer
disparar um portscan ou um scan do Nuclei **conscientemente**, não que o Claude
decida sozinho. O controle explícito é mais seguro aqui.

---

## 5. Configuração detalhada (o CONFIG)

Tudo gira em torno do bloco `CONFIG` no `CLAUDE.md`. Cada campo muda o
comportamento do Claude. Os principais:

| Campo | O que controla | Valores |
|-------|----------------|---------|
| `cenario` | Tipo de alvo (ativa o profile) | `web`, `api`, `mobile`, `network`, `redteam`, `bugbounty`, `corporate` — pode combinar: `[web, api]` |
| `abordagem` | Quanto você conhece do alvo | `blackbox`, `graybox`, `whitebox` |
| `profundidade` | Quão fundo o Claude vai | `recon-only`, `passive`, `standard`, `deep`, `full` |
| `metodologias.*` | Frameworks ativos | `true` / `false` por metodologia |
| `rules_of_engagement.*` | Limites técnicos | exploração ativa, pós-exploração, DoS, janela, rate limit |
| `classificacao_risco` | Como pontuar achados | `cvss3.1`, `cvss4.0`, `owasp_risk` |

### A `profundidade` é a trava mais importante

| Nível | O que o Claude faz |
|-------|--------------------|
| `recon-only` | Só reconhecimento, **nenhum** teste ativo |
| `passive` | Recon + análise passiva (sem tocar intrusivamente no alvo) |
| `standard` | Enumeração e validação **não-destrutiva** (padrão recomendado) |
| `deep` | Inclui exploração controlada com PoC |
| `full` | Inclui pós-exploração — **só com autorização explícita** |

> **Seguro por padrão:** comece em `standard`. Comandos ativos (ffuf, nuclei,
> portscan) exigem `standard` ou superior. Você precisa **subir conscientemente**
> para `deep`/`full` e marcar as permissões em `rules_of_engagement`.

---

## 6. O fluxo de trabalho

O fluxo segue **PTES** como espinha dorsal, com WSTG/OWASP guiando a profundidade:

```
1. Escopo & Pré-engajamento  →  specs/00-escopo.md
2. Reconhecimento            →  /recon
3. Modelagem de Ameaças      →  /threat-model
4. Enumeração & Análise      →  /enum
5. Validação                 →  /validate
6. Exploração (se permitido) →  manual + PoC
7. Pós-Exploração (se permit)→  manual
8. Análise de impacto        →  /chain
9. Relatório                 →  /report
10. Reteste                  →  /retest
```

### Pipeline recomendado (Web / Bug Bounty)
```
/subenum → /httprobe → /dns → /wayback → /crawl → /jssecrets
                            ↓
            /ffuf + /params + /tech + /graphql + /cloud
                            ↓
        /nuclei + /headers + /cors + /takeover
                            ↓
              /validate → /chain → /report → /retest
```

Ou rode fases inteiras de uma vez com os [scripts](#8-scripts-de-automação).

---

## 7. Referência de comandos

Os 24 comandos, por categoria. Detalhes completos em cada arquivo
`.claude/commands/<nome>.md`.

### Fases (orquestração macro)
| Comando | O que faz |
|---------|-----------|
| `/recon` | Orquestra toda a fase de reconhecimento |
| `/threat-model` | Modelagem de ameaças e priorização por risco |
| `/enum` | Enumeração e análise de vulnerabilidades |
| `/validate` | Confirma vulnerabilidades com prova reproduzível |
| `/report` | Gera o relatório final |

### Recon & Coleta
| Comando | Ferramentas | O que faz |
|---------|-------------|-----------|
| `/subenum` | subfinder, amass, assetfinder | Enumera subdomínios |
| `/httprobe` | httpx | Detecta hosts vivos + metadados |
| `/dns` | dnsx, dig | Resolução DNS, dangling CNAME |
| `/wayback` | gau, waybackurls | URLs históricas (arquivos públicos) |
| `/crawl` | katana | Crawling ativo da aplicação |
| `/tech` | whatweb, httpx | Fingerprint de tecnologias |

### Descoberta de superfície
| Comando | Ferramentas | O que faz |
|---------|-------------|-----------|
| `/ffuf` | ffuf | Fuzzing de dirs, arquivos, vhosts, parâmetros |
| `/portscan` | naabu, nmap | Varredura de portas e serviços |
| `/params` | arjun, paramspider | Descoberta de parâmetros ocultos |
| `/graphql` | graphw00f, clairvoyance | Introspection e testes de GraphQL |
| `/cloud` | cloud_enum, aws-cli | Buckets e recursos de nuvem expostos |

### Segredos & dados sensíveis
| Comando | Ferramentas | O que faz |
|---------|-------------|-----------|
| `/jssecrets` | LinkFinder, SecretFinder | Endpoints e chaves em JavaScript |
| `/gitleaks` | gitleaks, trufflehog | Segredos em repositórios git |

### Scan de vulnerabilidades
| Comando | Ferramentas | O que faz |
|---------|-------------|-----------|
| `/nuclei` | nuclei | Scan por templates (CVE, exposições, misconfig) |
| `/headers` | testssl, curl | Cabeçalhos de segurança e TLS |
| `/cors` | curl | Configuração CORS insegura |
| `/takeover` | subzy, nuclei | Confirmação de subdomain takeover |

### Análise de impacto & encerramento
| Comando | O que faz |
|---------|-----------|
| `/chain` | Encadeia achados numa cadeia de ataque (amplifica impacto) |
| `/retest` | Verifica se as correções aplicadas são efetivas |

---

## 8. Scripts de automação

Para rodar fases inteiras de uma vez (em `scripts/`). Cada script pede
**confirmação de escopo** antes de tocar no alvo.

### `recon-pipeline.sh` — recon completo
```bash
./scripts/recon-pipeline.sh alvo.com 30
#                            ^alvo    ^rate (req/s)
```
Encadeia: subdomínios → hosts vivos → URLs históricas → crawling → DNS/takeover →
resumo. Saída em `findings/recon/` + `recon-summary.md`.

### `scan-pipeline.sh` — scan de vulnerabilidades
```bash
./scripts/scan-pipeline.sh 30
```
Roda Nuclei (excluindo templates de DoS/intrusivos) + checagem de takeover.
**Todos** os achados passam por `/validate` depois.

> Os scripts têm **degradação graciosa**: se uma ferramenta não está instalada,
> a etapa é pulada em vez de quebrar o script.

---

## 9. Metodologias: quando ativar cada uma

Ative no `CONFIG` (`metodologias.*: true/false`). Detalhes em `specs/methodologies/`.

| Metodologia | Quando usar |
|-------------|-------------|
| **WSTG** | Sempre que houver alvo **Web**. É o checklist de cobertura mais detalhado. |
| **PTES** | Praticamente sempre — define as 7 fases macro de qualquer pentest. |
| **OSSTMM** | Engajamentos **amplos** (corporate, red team) que pedem métrica de postura. |
| **OWASP Web Top 10** | Para **classificar** achados Web em categorias reconhecidas. |
| **OWASP API Top 10** | Sempre que houver alvo de **API** (REST/GraphQL). |

> Combine livremente. Um pentest Web corporativo típico ativa WSTG + PTES +
> OWASP Web Top 10. Se houver API junto, adicione OWASP API Top 10.

---

## 10. Cenários: qual perfil para qual alvo

Defina em `cenario:`. Cada um ativa o profile em `specs/scenarios/`.

| Cenário | Use quando o alvo é |
|---------|---------------------|
| `web` | Aplicação web (páginas, formulários, fluxos) |
| `api` | API REST ou GraphQL |
| `mobile` | App Android/iOS (lembre: a maior parte das vulns está na API backend) |
| `network` | Infraestrutura, hosts, serviços de rede |
| `redteam` | Operação adversarial orientada a objetivo (exige `profundidade: full`) |
| `bugbounty` | Programa de bug bounty (as regras do programa têm prioridade) |
| `corporate` | Pentest completo (combina vários cenários) |

> **Pode combinar:** `cenario: [web, api]` é o caso mais comum em bug bounty
> moderno.

---

## 11. Gerando o relatório

Quando os achados em `findings/` estiverem com status final e evidências:

```
/report
```

Gera `report-final.md` com:
1. **Sumário executivo** — risco de negócio em linguagem não-técnica
2. **Metodologia** — abordagem, escopo, frameworks usados
3. **Matriz de achados** — tabela consolidada por severidade
4. **Detalhe técnico** — cada achado com impacto, evidência, remediação
5. **Recomendações priorizadas** — roadmap de correção
6. **Anexos** — evidências

A estrutura de cada achado segue `specs/reporting/report-template.md`. A
classificação de severidade segue `specs/reporting/cvss.md`.

> **Dica de impacto:** rode `/chain` antes do `/report`. Encadear vários achados
> "médios" numa cadeia de ataque costuma elevar a severidade — e a recompensa em
> bug bounty.

---

## 12. Modelo de segurança e uso responsável

O template foi desenhado para ser **seguro por padrão**. Os princípios embutidos:

1. **Autorização primeiro.** Sem `specs/00-escopo.md` preenchido, o Claude para
   antes de qualquer ação ativa.
2. **Escopo é lei.** Só o que está em `IN-SCOPE` é testável. Tudo fora é proibido,
   mesmo que acessível.
3. **Profundidade gradual.** Comandos ativos exigem `standard`+; exploração e
   pós-exploração exigem permissão explícita.
4. **Provar, não abusar.** Nos comandos de segredos/nuvem/takeover, a regra é
   provar a **exposição**, não explorar dados reais. Chaves são mascaradas no
   relatório.
5. **Rate limit e janela.** Todos os comandos respeitam o `rate_limit` e a
   `janela_de_testes`.
6. **Validação obrigatória.** Resultados de scanners automatizados (Nuclei, etc.)
   sempre passam por `/validate` — eles geram falsos positivos.
7. **Trilha de auditoria.** Tudo vira artefato rastreável em `findings/` e
   `evidence/`.

### O `.gitignore` protege dados de cliente
O template já ignora `findings/F-*.md`, `evidence/*`, outputs de ferramentas e
qualquer arquivo de credenciais (`*.env`, `*.key`, `secrets*`). **Nunca** force o
commit desses arquivos.

---

## 13. Exemplo prático completo

Um walkthrough de um engajamento de **bug bounty** fictício, do início ao fim.

### Cenário
Programa de bug bounty da "ExemploCorp" na HackerOne. Escopo: `*.exemplo.com`.
Regras: sem automação agressiva, sem DoS, sem acesso a dados de outros usuários.

### Passo 1 — Preparar
```bash
cp -r offensive-security-template bb-exemplocorp
cd bb-exemplocorp
```

Editar `specs/00-escopo.md`:
- Autorização: link do programa na HackerOne
- IN-SCOPE: `*.exemplo.com`
- OUT-OF-SCOPE: tudo que não for `exemplo.com`; APIs de terceiros
- Regras: DoS **não**, automação agressiva **não**, dados de usuários **não**

### Passo 2 — Configurar o `CLAUDE.md`
```yaml
cenario: [web, api]
abordagem: blackbox
profundidade: standard
metodologias:
  wstg: true
  ptes: true
  owasp_web_top10: true
  owasp_api_top10: true
rules_of_engagement:
  permite_exploracao_ativa: false
  permite_dos: false
  rate_limit: "10 req/s"
```

### Passo 3 — Abrir e confirmar
```bash
claude
```
Dentro do Claude Code:
```
> qual é o meu escopo e cenário configurado?
```
O Claude responde com `*.exemplo.com`, cenário web+api, blackbox, standard. ✅

### Passo 4 — Reconhecimento
```
/recon
```
O Claude orquestra `/subenum` → `/httprobe` → `/wayback` → `/crawl` →
`/jssecrets`, respeitando o rate de 10 req/s. Encontra, por exemplo:
- 47 subdomínios, 31 vivos
- Um `api-legacy.exemplo.com` esquecido (OWASP API9)
- Uma chave de API exposta num arquivo JS

### Passo 5 — Investigar os achados
```
/jssecrets
```
Confirma a chave exposta — **sem usá-la para acessar dados** (só valida que é
uma chave válida e mascara no registro). Vira `findings/F-001-api-key-exposed.md`.

```
/graphql
```
Testa o endpoint GraphQL de `api.exemplo.com`. Introspection está habilitada
(API8). Testa BOLA trocando IDs entre duas contas de teste → acessa dados de
outra conta. Vira `findings/F-002-graphql-bola.md` (Critical).

### Passo 6 — Validar
```
/validate
```
Reproduz cada achado com prova mínima, coleta evidência mascarada, atribui CVSS e
mapeia ao OWASP. F-002 confirmado como Critical (BOLA).

### Passo 7 — Encadear impacto
```
/chain
```
O Claude percebe: a chave exposta (F-001) dá acesso à API → o BOLA (F-002)
permite ler qualquer conta → juntos = exfiltração de dados de todos os usuários.
Cria `findings/CHAIN-001-account-data-exposure.md` com severidade elevada.

### Passo 8 — Relatório
```
/report
```
Gera `report-final.md` com sumário executivo, a cadeia de ataque em destaque, e
cada achado com remediação. Você adapta ao formato da HackerOne e submete.

### Passo 9 (depois) — Reteste
Quando a ExemploCorp corrigir:
```
/retest
```
Revalida F-001 e F-002, confirma se as correções resistem a bypass, e documenta
o antes/depois.

---

## 14. Solução de problemas (FAQ)

**O Claude Code não parece estar usando o `CLAUDE.md`.**
Confirme que você abriu o `claude` **dentro** da pasta do template (onde está o
`CLAUDE.md` na raiz). Rode `/memory` para ver os arquivos carregados. Se editou o
`CLAUDE.md` com a sessão aberta, use `/memory` para recarregar ou reinicie.

**Os comandos `/recon`, `/nuclei` etc. não aparecem.**
Verifique que a pasta `.claude/commands/` está na raiz do projeto e contém os
`.md`. Digite `/` e filtre pelo nome. Se nada aparece, confirme que você está no
diretório certo.

**O Claude não está lendo os arquivos `specs/`.**
Eles carregam sob demanda. Ou um comando precisa referenciá-los, ou você adiciona
um import `@specs/...` no `CLAUDE.md`. Você também pode simplesmente pedir:
"leia `specs/scenarios/web.md` e siga o profile".

**Uma ferramenta dá "command not found".**
Ela não está instalada. Veja `specs/tooling.md` para instalar, ou rode sem ela —
os scripts pulam etapas de ferramentas ausentes.

**O Claude se recusa a fazer algo.**
Provavelmente está fora do escopo, acima da profundidade configurada, ou
esbarra numa regra de engajamento. Confirme `specs/00-escopo.md` e o `CONFIG`. As
travas de segurança são intencionais.

**Posso rodar tudo sem confirmar escopo?**
Não — e isso é proposital. A confirmação de escopo é a principal proteção contra
testar algo não autorizado por acidente.

---

## 15. Estendendo o template

O template é modular e feito para crescer com a sua prática.

**Adicionar um comando:** crie `.claude/commands/<nome>.md` com as instruções. O
nome do arquivo vira `/<nome>`. Considere adicionar frontmatter YAML:
```markdown
---
description: O que o comando faz
argument-hint: [alvo]
allowed-tools: Bash, Read, Grep
---
# /<nome> — ...
```

**Adicionar um cenário:** crie `specs/scenarios/<nome>.md` com superfície,
fluxo por fase, vetores prioritários e cuidados. Adicione o nome às opções de
`cenario` no `CLAUDE.md`.

**Adicionar um script:** siga o padrão dos existentes — confirmação de escopo no
início, rate como parâmetro, degradação graciosa, saída em `findings/`.

**Migrar para skills (opcional):** se quiser que o Claude invoque comandos
autonomamente, mova para `.claude/skills/<nome>/SKILL.md`. Para segurança, o
controle explícito de `.claude/commands/` costuma ser preferível.

**Ideias de expansão:**
- `secrets-pipeline.sh` — combina `/jssecrets` + `/gitleaks`
- `api-pipeline.sh` — focado em descoberta de endpoints de API
- Cenários adicionais: `cloud`, `ad` (Active Directory), `iot`
- Wordlists e templates de Nuclei customizados por engajamento

---

> **Lembre-se sempre:** autorização por escrito, escopo respeitado, e a regra de
> ouro — provar o risco, nunca causar dano. Bom trabalho. 🛡️
