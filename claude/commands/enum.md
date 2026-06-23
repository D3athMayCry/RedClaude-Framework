# /enum — Enumeração e Análise

Execute a enumeração detalhada e análise de vulnerabilidades (PTES: Vulnerability
Analysis).

## Antes de executar
1. Leia `findings/threat-model.md` para saber as prioridades.
2. Carregue as metodologias ativas (`specs/methodologies/`) e o profile do cenário.

## O que fazer
- Percorrer o **checklist da metodologia ativa**:
  - Web → categorias WSTG (`methodologies/wstg.md`)
  - API → checklist OWASP API (`methodologies/owasp-api-top10.md`)
  - Network → enumeração por serviço (`scenarios/network.md`)
- Identificar **possíveis** vulnerabilidades (modo detecção).
- Respeitar a `profundidade`:
  - `standard` → detecção não-destrutiva, sem exploração
  - `deep`/`full` → pode preparar PoC para confirmar em `/validate`
- Respeitar `rate_limit` e `janela_de_testes`.

## Saída
Para cada vulnerabilidade **suspeita**, crie um rascunho em
`findings/F-XXX-titulo.md` usando `specs/reporting/report-template.md`, com
status `Suspeito`. A confirmação acontece em `/validate`.

## Lembrete
Modo detecção ≠ exploração. Não execute payloads destrutivos. Mantenha tudo
dentro do escopo e da profundidade configurada.
