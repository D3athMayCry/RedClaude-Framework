# /retest — Verificação de Correção

Revalida achados após o cliente/programa aplicar correções, confirmando se a
remediação foi efetiva. Fase comum em pentest corporativo e em bug bounty
(reteste de fix).

## Pré-checagem
- Liste os achados com status `Confirmado` em `findings/` que foram reportados.
- Confirme que houve uma rodada de correção e que o reteste está autorizado.

## Processo
Para cada achado a revalidar:
1. **Reproduza os passos originais** documentados em `findings/F-XXX-*.md`.
2. Classifique o resultado:
   - ✅ **Corrigido** — não é mais explorável
   - ⚠️ **Parcial** — mitigado, mas contornável (documente o bypass)
   - ❌ **Não corrigido** — ainda explorável
   - ↪️ **Regressão/variante** — a correção abriu outro caminho
3. **Teste bypasses** da correção: filtros e validações costumam ser contornáveis
   (encoding, métodos alternativos, parâmetros adicionais).
4. **Atualize** o achado com o status de reteste, data e nova evidência.

## Atualização do achado
Adicione ao arquivo do achado:

```markdown
### Reteste — <YYYY-MM-DD>
**Status:** Corrigido / Parcial / Não corrigido / Variante
**Verificação:** <o que foi testado para confirmar>
**Bypass encontrado:** <se aplicável, descreva e classifique como novo achado>
**Evidência:** <nova evidência, dados mascarados>
```

## Saída
- Achados em `findings/` atualizados com a seção de reteste.
- Bypasses/variantes viram **novos achados** (`F-XXX`) com seu próprio fluxo.
- `/report` pode gerar um **relatório de reteste** mostrando o antes/depois e a
  taxa de correção.

## Regras
- Use os mesmos passos do achado original para uma comparação justa.
- Um filtro adicionado não é "corrigido" se for trivialmente contornável —
  teste antes de marcar como resolvido.
- Mantenha-se no escopo e na profundidade autorizada.

> O reteste fecha o ciclo do engajamento e prova o valor entregue: o que foi
> efetivamente reduzido na superfície de risco.
