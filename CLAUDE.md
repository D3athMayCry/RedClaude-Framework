<p align="center">
  <img src="./assets/redclaude-logo.png" width="300">
</p>

# CLAUDE.md — Configuração Global de Operação de Segurança Ofensiva

> Este é o arquivo central. O Claude Code o carrega automaticamente.
> Edite o bloco `CONFIG` abaixo para cada engajamento. Todo o resto da estrutura
> (specs, comandos, cenários) reage a estes valores.

---

## Política de Skills (autoinvocação)

As skills em `.claude/skills/` têm **autoinvocação habilitada** — o Claude pode
disparar a skill apropriada quando reconhecer a intenção, sem o usuário precisar
digitar `/comando`. Isso acelera o fluxo, mas em segurança ofensiva exige uma
trava por **categoria**:

| Categoria (`metadata.category`) | Autoinvocação | Confirmação explícita? |
|---|---|---|
| `phase` (recon, validate, report…) | ✅ livre | ❌ não |
| `analysis` (threat-model, chain, report) | ✅ livre | ❌ não |
| `passive-recon` (subenum, wayback, jssecrets…) | ✅ livre | ❌ não |
| `active-recon` (httprobe, crawl, params…) | ✅ livre | ⚠️ confirme alvo+rate |
| `active-offensive` (nuclei, ffuf, portscan…) | ⚠️ pode planejar | ✅ **OBRIGATÓRIA** |

### Regras de execução

1. Para skills `active-offensive` (`requires-explicit-confirmation: true` no
   frontmatter), o Claude **pode preparar comandos e explicar o plano**, mas
   **NÃO executa** o tráfego ativo até receber confirmação explícita do
   usuário na sessão (ex.: "pode rodar", "ok, dispara", "execute agora").
2. Antes de executar qualquer skill ativa, o Claude verifica `specs/00-escopo.md`
   e o `CONFIG` (profundidade, rate_limit, janela_de_testes).
3. Skills `active-offensive` **nunca rodam** em `profundidade: recon-only` ou
   `passive`. Para rodar, exige `standard` ou superior.
4. Se uma skill `active-offensive` for autoinvocada pela intenção, o Claude
   anuncia: "Identifiquei que faz sentido rodar a skill X. Aqui está o comando
   preparado: [...]. Confirme com 'rodar' para executar." E aguarda.
5. Resultados de scanners (Nuclei, FFUF) **sempre** passam por `/validate`
   antes de virarem achados — eles geram falsos positivos.

> Filosofia: máxima autonomia para coletar, planejar e analisar; trava na hora
> de mandar pacote ativo ao alvo. O Claude é o navegador; você dá o "vai".

## 🧩 CONFIG — Edite por engajamento

```yaml
# ───────────────────────────────────────────────
# IDENTIDADE DO ENGAJAMENTO
# ───────────────────────────────────────────────
engagement:
  nome: "<NOME_DO_PROJETO>"
  cliente: "<CLIENTE / PROGRAMA>"
  data_inicio: "<YYYY-MM-DD>"
  data_fim: "<YYYY-MM-DD>"
  responsavel: "<SEU_NOME / HANDLE>"

# ───────────────────────────────────────────────
# TIPO DE CENÁRIO  (ativa o profile correspondente)
# Opções: web | api | mobile | network | redteam | bugbounty | corporate
# Pode combinar: [web, api]
# ───────────────────────────────────────────────
cenario: [web]

# ───────────────────────────────────────────────
# ABORDAGEM
# Opções: blackbox | graybox | whitebox
# ───────────────────────────────────────────────
abordagem: graybox

# ───────────────────────────────────────────────
# PROFUNDIDADE  (controla o quão fundo o Claude vai)
# Opções:
#   recon-only   -> só reconhecimento, sem testes ativos
#   passive      -> recon + análise passiva
#   standard     -> enumeração + validação não-destrutiva
#   deep         -> exploração controlada + PoC
#   full         -> inclui pós-exploração (somente se autorizado)
# ───────────────────────────────────────────────
profundidade: standard

# ───────────────────────────────────────────────
# METODOLOGIAS  (ative/desative conforme o contexto)
# Cada uma referencia um arquivo em specs/methodologies/
# ───────────────────────────────────────────────
metodologias:
  wstg:            true    # OWASP Web Security Testing Guide
  ptes:            true    # Penetration Testing Execution Standard
  osstmm:          false   # Open Source Security Testing Methodology Manual
  owasp_web_top10: true    # OWASP Top 10 Web
  owasp_api_top10: false   # OWASP API Security Top 10

# ───────────────────────────────────────────────
# REGRAS DE ENGAJAMENTO  (limites técnicos)
# ───────────────────────────────────────────────
rules_of_engagement:
  permite_exploracao_ativa:   false
  permite_pos_exploracao:     false
  permite_dos:                false
  permite_engenharia_social:  false
  janela_de_testes:           "<ex: 09:00-18:00 BRT, dias úteis>"
  rate_limit:                 "<ex: máx 10 req/s>"
  contato_emergencia:         "<email / telefone do cliente>"

# ───────────────────────────────────────────────
# CLASSIFICAÇÃO DE RISCO
# Opções: cvss3.1 | cvss4.0 | owasp_risk
# ───────────────────────────────────────────────
classificacao_risco: cvss3.1
```

---

## 🔁 Como o Claude deve operar

Ao iniciar uma tarefa, o Claude Code deve:

1. **Ler este CONFIG** e identificar `cenario`, `abordagem`, `profundidade` e
   `metodologias` ativas.
2. **Carregar o profile** correspondente em `specs/scenarios/<cenario>.md`.
3. **Carregar as metodologias ativas** de `specs/methodologies/`.
4. **Validar o escopo** em `specs/00-escopo.md` antes de qualquer ação ativa.
5. **Respeitar a profundidade**: nunca ir além do nível configurado. Se
   `profundidade: standard`, não explorar ativamente nem fazer pós-exploração.
6. **Registrar achados** em `findings/` usando o formato de `specs/reporting/report-template.md`.
7. **Mapear cada achado** para OWASP Top 10 / API Top 10 e calcular o risco
   conforme `classificacao_risco`.

---

## 🗂️ Mapa da estrutura

```
.
├── CLAUDE.md                      ← você está aqui (config central)
├── README.md                     ← guia de uso
├── specs/
│   ├── 00-escopo.md              ← PREENCHA antes de começar (autorização)
│   ├── methodologies/            ← referência das metodologias
│   │   ├── wstg.md
│   │   ├── ptes.md
│   │   ├── osstmm.md
│   │   ├── owasp-web-top10.md
│   │   └── owasp-api-top10.md
│   ├── scenarios/                ← profiles por tipo de alvo
│   │   ├── web.md   ├── api.md   ├── mobile.md
│   │   ├── network.md ├── redteam.md
│   │   ├── bugbounty.md └── corporate.md
│   └── reporting/
│       ├── cvss.md               ← guia de classificação
│       └── report-template.md    ← modelo de relatório
├── .claude/skills/               ← skills com autoinvocação (formato atual)
│   └── <nome>/SKILL.md
├── .claude/commands/             ← comandos /custom (fallback legado, ainda funcional)
│   ├── recon.md  ├── enum.md  ├── threat-model.md
│   ├── validate.md  └── report.md
├── findings/                     ← achados (1 arquivo por vuln)
├── evidence/                     ← prints, logs, PoCs
└── scripts/                      ← automações auxiliares
```

---

## 🧭 Fases do fluxo (resumo)

O fluxo segue PTES como espinha dorsal, com WSTG/OWASP guiando a profundidade:

1. **Escopo & Pré-engajamento** → `specs/00-escopo.md`
2. **Reconhecimento** → `/recon`
3. **Modelagem de Ameaças** → `/threat-model`
4. **Enumeração & Análise** → `/enum`
5. **Validação de Vulnerabilidades** → `/validate`
6. **Exploração** (se `permite_exploracao_ativa: true`) → manual + PoC
7. **Pós-Exploração** (se `permite_pos_exploracao: true`) → manual
8. **Relatório** → `/report`

Os detalhes de cada fase por cenário estão nos profiles em `specs/scenarios/`.

---

## 🧰 Índice de comandos

Comandos disponíveis em `.claude/commands/`. O arsenal completo de ferramentas
está documentado em `specs/tooling.md`.

### Fases (orquestração macro — PTES)
| Comando | Fase |
|---------|------|
| `/recon` | Reconhecimento (orquestra os comandos de coleta abaixo) |
| `/threat-model` | Modelagem de ameaças |
| `/enum` | Enumeração e análise |
| `/validate` | Validação de vulnerabilidades |
| `/report` | Relatório final |

### Recon & Coleta (passivo → ativo leve)
| Comando | Ferramentas | O que faz |
|---------|-------------|-----------|
| `/subenum` | subfinder, amass, assetfinder | Enumera subdomínios |
| `/httprobe` | httpx | Detecta hosts vivos + metadados |
| `/dns` | dnsx, dig | Resolução DNS, dangling CNAME (takeover) |
| `/wayback` | gau, waybackurls | URLs históricas (Wayback/CommonCrawl) |
| `/crawl` | katana | Crawling ativo da aplicação |
| `/tech` | whatweb, httpx | Fingerprint de tecnologias |

### Descoberta de conteúdo & superfície (ativo)
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

### Automação (pasta `scripts/`)
| Script | O que faz |
|--------|-----------|
| `recon-pipeline.sh` | Roda toda a fase de recon de uma vez |
| `scan-pipeline.sh` | Roda o scan de vulnerabilidades (Nuclei + takeover) |

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

> **Regra de ouro do tooling:** todo comando respeita `profundidade`, `rate_limit`,
> `janela_de_testes` e o IN-SCOPE. Comandos ativos (ffuf, nuclei, portscan, crawl)
> exigem `profundidade: standard`+. Resultados de scanners automatizados sempre
> passam por `/validate` antes de virar achado — eles geram falsos positivos.
