# 00 — Escopo e Regras de Engajamento

> ⚠️ **OBRIGATÓRIO.** O Claude Code não deve executar nenhuma ação ativa enquanto
> este documento não estiver preenchido e a autorização confirmada.

## ✅ Autorização

- [ ] Existe autorização **por escrito** para este teste
- [ ] O autorizador tem poder para conceder essa permissão
- [ ] As datas de execução estão dentro da janela autorizada
- [ ] (Bug bounty) O programa está ativo e o escopo confere com a plataforma

**Documento de autorização:** `<link / referência ao contrato ou programa>`
**Autorizado por:** `<nome, cargo>`
**Data da autorização:** `<YYYY-MM-DD>`

## 🎯 Tipo de alvo

`<web | api | mobile | network | redteam | bugbounty | corporate>`

## 🟢 IN-SCOPE (autorizado)

Liste explicitamente. Só o que está aqui pode ser testado.

| Ativo | Tipo | Observações |
|-------|------|-------------|
| `app.exemplo.com` | Web | Produção |
| `api.exemplo.com/v2/*` | API | |
| `203.0.113.0/24` | Network | Apenas portas TCP |
| | | |

## 🔴 OUT-OF-SCOPE (proibido)

| Ativo | Motivo |
|-------|--------|
| `*.terceiro.com` | Infraestrutura de terceiros |
| `admin-legacy.exemplo.com` | Sistema crítico de produção |
| Qualquer subdomínio não listado em IN-SCOPE | Fora do acordo |

## 📋 Regras de engajamento

| Regra | Permitido? | Detalhe |
|-------|-----------|---------|
| Exploração ativa | `<sim/não>` | |
| Pós-exploração | `<sim/não>` | |
| Negação de serviço (DoS) | **Não** | |
| Engenharia social | `<sim/não>` | |
| Testes em produção | `<sim/não>` | |
| Acesso a dados de usuários reais | `<sim/não>` | Mascarar sempre |
| Janela de testes | | `<ex: 09h-18h BRT>` |
| Rate limit | | `<ex: 10 req/s>` |

## 🚨 Contatos

- **Contato técnico do cliente:** `<nome / email / telefone>`
- **Emergência / parar tudo:** `<canal de comunicação imediato>`
- **O que fazer se achar algo crítico:** `<ex: notificar imediatamente antes de prosseguir>`

## 📝 Notas adicionais

`<credenciais de teste fornecidas, contas, ambientes, IPs de origem permitidos, etc.>`
