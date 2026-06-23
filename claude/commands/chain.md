# /chain — Encadeamento de Vulnerabilidades

Combina achados individuais numa cadeia de ataque para demonstrar o **impacto
real de negócio**. Um conjunto de bugs "médios" encadeados costuma valer muito
mais — em severidade e em recompensa — do que isolados.

## Quando usar
- Após `/validate`, com vários achados confirmados em `findings/`.
- Antes de `/report`, para elevar a narrativa de impacto.

## Como construir uma cadeia
1. **Liste os achados confirmados** e o que cada um concede ao atacante.
2. **Pergunte:** a saída de um achado é a entrada de outro?
   - Ex.: info disclosure → vaza endpoint admin → IDOR nesse endpoint → takeover de conta
3. **Monte o caminho** do estado inicial (atacante anônimo) até o objetivo
   (dados sensíveis, conta admin, RCE).
4. **Reavalie a severidade** da cadeia como um todo (geralmente > soma das partes).

## Padrões clássicos de encadeamento
| Cadeia | Resultado |
|--------|-----------|
| Info disclosure → credencial em JS → acesso à API | Comprometimento de dados |
| IDOR → enumeração de usuários → reset de senha fraco | Account takeover |
| SSRF → metadados de nuvem (169.254.169.254) → credenciais IAM | Comprometimento de infra |
| Open redirect → OAuth token leak → sequestro de sessão | Account takeover |
| XSS armazenado → roubo de token de admin → painel administrativo | Comprometimento total |
| Subdomain takeover → bypass de CORS → roubo de dados autenticados | Exfiltração |
| Upload sem validação → web shell → RCE | Execução remota |

## Documentação da cadeia
Crie `findings/CHAIN-XXX-titulo.md`:

```markdown
## CHAIN-XXX — <Título do cenário de ataque>

**Severidade da cadeia:** <reavaliada, geralmente maior que a dos achados isolados>
**Objetivo alcançado:** <o que o atacante consegue ao final>

### Achados encadeados
- F-001 (<sev>) — <o que concede>
- F-005 (<sev>) — <o que concede>
- F-008 (<sev>) — <o que concede>

### Caminho de ataque (passo a passo)
1. Como atacante anônimo, exploro F-001 para obter <X>
2. Com <X>, uso F-005 para alcançar <Y>
3. Com <Y>, F-008 leva a <objetivo final>

### Impacto de negócio
<Tradução para risco real: vazamento de N registros, controle de contas, etc.>

### Evidência
<Referência às evidências de cada etapa, dados mascarados>
```

## Regras
- Cada elo precisa ser **realmente confirmado** — não encadeie suposições.
- Mantenha-se no escopo em **todas** as etapas; a cadeia não autoriza sair dele.
- Pare no necessário para provar o caminho; não cause dano ao demonstrar.
- Comunique cadeias críticas imediatamente ao contato do escopo.

## Saída
- `findings/CHAIN-XXX-*.md` — usado pelo `/report` como destaque de impacto.

> Encadear é o que diferencia um relatório técnico de um relatório que demonstra
> risco de negócio. É também onde está a maior recompensa em bug bounty.
