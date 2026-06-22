# Profile — Aplicação Web

> Ativado por `cenario: [web]`. Combine com WSTG + OWASP Web Top 10.

## Superfície de ataque
Páginas, formulários, parâmetros (GET/POST/headers/cookies), endpoints de API
internos, uploads, autenticação, fluxos de negócio, integrações de terceiros,
arquivos estáticos e código JS client-side.

## Fluxo por fase

### Recon
- Fingerprint de tecnologias (servidor, framework, CMS, WAF)
- Enumeração de subdomínios e diretórios/arquivos
- Coleta de endpoints a partir do JS e do tráfego
- Mapa do sitemap e pontos de entrada autenticados/não autenticados

### Modelagem de ameaças
- Identificar funcionalidades sensíveis (auth, pagamento, admin, upload)
- Mapear fronteiras de confiança e fluxos de dados

### Enumeração & Análise
- Cobrir categorias WSTG aplicáveis (ver `methodologies/wstg.md`)
- Atenção a: controle de acesso (A01), injeção (A03), misconfiguration (A05)

### Validação
- Confirmar achados com prova mínima e reproduzível
- Classificar via CVSS, mapear ao OWASP Top 10

## Vetores prioritários (mais alto retorno)
1. Broken Access Control / IDOR
2. Injeção (SQLi, XSS, SSTI, command injection)
3. Falhas de autenticação e sessão
4. SSRF
5. Misconfiguration (headers, CORS, arquivos expostos)
6. Lógica de negócio

## Categorias de ferramentas (não-destrutivas por padrão)
- Proxy de interceptação para análise de requisições
- Fingerprinting de tecnologias
- Enumeração de conteúdo/diretórios
- Scanners de configuração e headers
- Análise de JS client-side

> Respeite `rate_limit` e `janela_de_testes` do CONFIG. Em produção, prefira
> testes manuais e de baixa intensidade.
