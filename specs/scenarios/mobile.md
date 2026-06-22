# Profile — Aplicação Mobile (Android / iOS)

> Ativado por `cenario: [mobile]`. Referência: OWASP MASVS / MASTG.

## Superfície de ataque
Binário do app, armazenamento local, comunicação com backend (geralmente uma API
— combine com `api.md`), criptografia client-side, IPC, deep links, hardcoded
secrets, controles anti-tampering.

## Fluxo por fase

### Recon
- Análise estática do pacote (APK/IPA): permissões, componentes, secrets
- Identificar endpoints e chaves embutidas no binário
- Mapear armazenamento local e dados em repouso

### Modelagem de ameaças
- Dispositivo comprometido / rooteado-jailbroken
- Interceptação de tráfego (MITM)
- Análise do binário por terceiros

### Enumeração & Análise (categorias MASVS)
- **Storage** — dados sensíveis em claro no dispositivo
- **Crypto** — uso correto de criptografia
- **Auth** — autenticação e gestão de sessão
- **Network** — TLS, certificate pinning
- **Platform** — IPC, WebViews, deep links
- **Code** — proteção do binário, anti-debugging
- **Resilience** — anti-tampering, detecção de root/jailbreak

### Validação
- Confirmar com dispositivo/emulador de teste autorizado
- Documentar caminho de exploração

## Vetores prioritários
1. Dados sensíveis em armazenamento inseguro
2. Comunicação insegura / ausência de pinning
3. Secrets hardcoded no binário
4. Falhas na API backend (→ ver `api.md`)
5. Componentes exportados / deep links inseguros

## Notas
- A maior parte das vulnerabilidades "mobile" reais está na API backend.
  Sempre teste a API em conjunto.
