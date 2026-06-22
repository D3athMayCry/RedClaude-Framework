# Template — Relatório de Achado

> Copie este modelo para cada vulnerabilidade em `findings/F-XXX-titulo.md`.
> O comando `/report` agrega todos num relatório final.

---

## F-XXX — <Título claro e específico>

| Campo | Valor |
|-------|-------|
| **ID** | F-XXX |
| **Severidade** | Critical / High / Medium / Low / Info |
| **CVSS** | `<score>` — `<vetor completo>` |
| **Categoria OWASP** | A0X (Web) ou APIX (API) |
| **Status** | Confirmado / Suspeito / Falso-positivo |
| **Alvo** | `<URL / host / endpoint afetado>` |
| **Data** | YYYY-MM-DD |

### Descrição
<O que é a vulnerabilidade, em linguagem técnica e objetiva.>

### Impacto
<O que um atacante consegue fazer. Traduza para risco de negócio:
acesso a dados, comprometimento de contas, perda financeira, etc.>

### Passos para reproduzir
1. <Passo 1 — preciso e reproduzível>
2. <Passo 2>
3. <Resultado observado>

> Mascare dados sensíveis (PII, credenciais reais). Use `[REDACTED]`.

### Evidência
<Referência aos arquivos em evidence/: prints, logs, request/response.>
```
<request/response relevante, com dados sensíveis mascarados>
```

### Remediação recomendada
<Como corrigir. Seja específico e acionável. Cite a defesa correta,
não apenas "validar entrada".>

### Referências
- <WSTG-XXX correspondente>
- <CWE-XXX, se aplicável>
- <Documentação do fabricante / OWASP cheat sheet>

---

## Estrutura do relatório final (gerado por /report)

1. **Sumário executivo** — postura geral, riscos principais, em linguagem de negócio
2. **Metodologia** — abordagem, escopo, metodologias usadas, janela
3. **Matriz de achados** — tabela consolidada por severidade
4. **Detalhe técnico** — cada achado no formato acima
5. **Recomendações priorizadas** — roadmap de remediação
6. **Anexos** — evidências, ferramentas, logs
