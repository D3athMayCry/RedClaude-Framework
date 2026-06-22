# Profile — Pentest Corporativo Completo

> Ativado por `cenario: [corporate]`. Engajamento abrangente, geralmente
> combinando múltiplos cenários (web + api + network). Combine todas as
> metodologias relevantes, incluindo OSSTMM para métrica.

## Característica
Avaliação completa da postura de segurança de uma organização, com contrato
formal, escopo amplo e relatório executivo + técnico para stakeholders.

## Composição típica
Este profile geralmente ativa vários cenários simultaneamente:
- `web.md` para aplicações
- `api.md` para serviços
- `network.md` para infraestrutura
- Opcionalmente `mobile.md` e `redteam.md`

## Fluxo (PTES completo)

1. **Pré-engajamento** — escopo formal, contrato, regras → `00-escopo.md`
2. **Inteligência** — recon de toda a superfície autorizada → `/recon`
3. **Modelagem de ameaças** — por sistema e relações de confiança → `/threat-model`
4. **Análise de vulnerabilidades** — enumeração ampla → `/enum`, `/validate`
5. **Exploração** — conforme autorização, com PoC
6. **Pós-exploração** — avaliação de impacto organizacional
7. **Relatório** — executivo + técnico → `/report`

## Entregáveis esperados
- **Sumário executivo** — risco de negócio em linguagem não-técnica
- **Detalhe técnico** — cada achado com evidência e remediação
- **Matriz de risco** — visão consolidada por severidade
- **Roadmap de remediação** — priorização das correções
- **Métricas** (se OSSTMM ativo) — RAV / postura quantitativa

## Cuidados
- Coordenação constante com o time interno do cliente
- Janelas de teste bem definidas para sistemas de produção
- Comunicação imediata de achados críticos
- Documentação rigorosa para auditoria e compliance
