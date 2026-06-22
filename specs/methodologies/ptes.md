# Metodologia — PTES (Penetration Testing Execution Standard)

> Ative com `metodologias.ptes: true`. PTES é a espinha dorsal do fluxo — define
> as 7 fases macro de qualquer pentest, independente do tipo de alvo.

## As 7 fases

### 1. Pré-engajamento (Pre-engagement Interactions)
- Definição de escopo, objetivos e regras de engajamento → `specs/00-escopo.md`
- Janelas de teste, contatos de emergência, autorização por escrito
- Definição de abordagem (black/gray/white box) e profundidade
- **Gate:** não avançar sem escopo e autorização confirmados.

### 2. Coleta de Inteligência (Intelligence Gathering)
- OSINT passivo: domínios, e-mails, tecnologias, vazamentos
- Footprinting ativo (se autorizado): DNS, portas, serviços
- Mapeamento da superfície de ataque
- Comando: `/recon`

### 3. Modelagem de Ameaças (Threat Modeling)
- Identificação de ativos de valor e vetores de ataque
- Modelagem do atacante (motivação, capacidade)
- Priorização por risco (probabilidade × impacto)
- Comando: `/threat-model`

### 4. Análise de Vulnerabilidades (Vulnerability Analysis)
- Enumeração de serviços, endpoints, tecnologias
- Identificação de vulnerabilidades (manual + automatizado)
- Correlação com bases conhecidas (CVE, exploits públicos)
- Comandos: `/enum`, `/validate`

### 5. Exploração (Exploitation)
- Execução controlada de testes ofensivos — **somente se**
  `permite_exploracao_ativa: true`
- Foco em prova de conceito, não em causar dano
- Documentação de cada passo reproduzível

### 6. Pós-Exploração (Post Exploitation)
- **Somente se** `permite_pos_exploracao: true`
- Avaliação de impacto: o que o acesso permite alcançar
- Escalonamento de privilégios, persistência, movimento lateral
- Coleta de evidência mínima necessária; limpeza ao final

### 7. Relatório (Reporting)
- Sumário executivo + detalhe técnico
- Cada achado com impacto, evidência, classificação e remediação
- Comando: `/report` → usa `specs/reporting/report-template.md`

## Princípio orientador

PTES define *o quê* fazer e em que ordem. WSTG/OWASP definem *como* testar cada
camada. OSSTMM adiciona métricas e cobertura de canais quando ativado.
