---
name: report
description: "Gera o relatório final consolidando todos os achados confirmados em um documento profissional com sumário executivo, metodologia, matriz de achados, detalhe técnico e recomendações priorizadas. Use sempre que o usuário pedir 'gere o relatório', 'consolide os achados', 'crie o report' ou similar. Sem tráfego ao alvo."
disable-model-invocation: false
allowed-tools: Read, Write, Grep, Glob
metadata:
  version: "1.0"
  category: analysis
  requires-explicit-confirmation: "false"
  framework: offensive-security-template
---

# Geração do Relatório

Agregue todos os achados num relatório profissional.

## Antes de executar
1. Confirme que os achados em `findings/` estão com status final e evidências.
2. Leia `specs/reporting/report-template.md` para a estrutura.

## O que fazer
Gere `report-final.md` com:

1. **Sumário executivo** — postura geral e principais riscos em linguagem de
   negócio (para gestores não-técnicos).
2. **Metodologia** — abordagem (black/gray/white box), escopo, metodologias
   ativas, janela de testes.
3. **Matriz de achados** — tabela consolidada ordenada por severidade:
   | ID | Título | Severidade | CVSS | OWASP | Status |
4. **Detalhe técnico** — cada achado confirmado no formato do template, com
   descrição, impacto, passos, evidência e remediação.
5. **Recomendações priorizadas** — roadmap de correção (o que corrigir primeiro).
6. **Anexos** — lista de evidências em `evidence/`.

## Requisitos de qualidade
- Dados sensíveis mascarados em todo o relatório.
- Cada achado com remediação **acionável** e específica.
- Severidades consistentes entre si.
- Para bug bounty, adapte ao formato exigido pelo programa.

## Saída
`report-final.md` na raiz do projeto, pronto para revisão e entrega.
