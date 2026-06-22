# Profile — Bug Bounty

> Ativado por `cenario: [bugbounty]`. As regras do programa têm prioridade
> absoluta sobre este template.

## Antes de tudo
- [ ] Ler o escopo do programa na plataforma (HackerOne/Bugcrowd/Intigriti/etc.)
- [ ] Copiar o escopo exato para `specs/00-escopo.md`
- [ ] Verificar o que é OUT-OF-SCOPE (respeitar rigorosamente)
- [ ] Ler as regras: testes proibidos, rate limits, requisitos de relatório
- [ ] Verificar se DoS, engenharia social e automação são permitidos (geralmente não)

## Estratégia
Bug bounty premia **achados válidos e bem documentados**, não volume de ruído.

### Recon (onde está o maior retorno)
- Enumeração ampla de subdomínios e ativos
- Identificação de tecnologias e versões
- Mapeamento de endpoints e funcionalidades
- Procurar ativos esquecidos / mal configurados (alta taxa de sucesso)

### Caça focada
- Priorizar categorias de alto impacto e alta aceitação:
  - IDOR / Broken Access Control
  - SSRF
  - Injeção
  - Falhas de autenticação
  - Misconfiguration e information disclosure
- Evitar duplicatas: ir além do óbvio que todos já testaram

### Validação rigorosa
- Confirmar o achado de forma reproduzível
- Coletar evidência clara (request/response, prints)
- Avaliar o impacto real de negócio

### Relatório
- Seguir o formato exigido pelo programa
- Título claro, passos reproduzíveis, impacto, evidência, remediação
- Usar `specs/reporting/report-template.md` como base

## Regras de ouro
1. **Escopo do programa é lei.** Nunca teste fora dele.
2. **Sem automação agressiva** a menos que explicitamente permitida.
3. **Não acesse dados de outros usuários** além do mínimo para provar o achado.
4. **Reporte achados críticos imediatamente**, antes de explorar mais.
5. **Respeite a divulgação responsável** — não publique sem autorização.
