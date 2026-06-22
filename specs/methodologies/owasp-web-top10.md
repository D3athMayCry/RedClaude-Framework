# Metodologia — OWASP Top 10 (Web) 2021

> Ative com `metodologias.owasp_web_top10: true`. Use para **classificar e mapear**
> cada achado Web a uma categoria reconhecida no relatório.

Todo achado em `findings/` deve referenciar a categoria OWASP correspondente.

## As 10 categorias

### A01 — Broken Access Control
Falhas de controle de acesso. Inclui IDOR, bypass de autorização, escalonamento
de privilégios, force browsing. **Categoria nº1 mais comum.**

### A02 — Cryptographic Failures
Exposição de dados sensíveis por criptografia ausente ou fraca. TLS obsoleto,
dados em claro, hashing inadequado, chaves expostas.

### A03 — Injection
Injeção de código/comandos: SQL, NoSQL, OS command, LDAP, XSS (incluído aqui na
taxonomia 2021), SSTI.

### A04 — Insecure Design
Falhas de design e arquitetura — ausência de controles por concepção, não por
implementação. Modelagem de ameaças ausente.

### A05 — Security Misconfiguration
Configuração insegura: defaults, recursos desnecessários, headers ausentes,
mensagens de erro verbosas, XXE.

### A06 — Vulnerable and Outdated Components
Bibliotecas, frameworks e dependências desatualizadas ou vulneráveis.

### A07 — Identification and Authentication Failures
Autenticação quebrada: credential stuffing, sessões mal gerenciadas, MFA ausente,
recuperação de senha fraca.

### A08 — Software and Data Integrity Failures
Falhas de integridade: deserialização insegura, CI/CD comprometido, updates sem
verificação de assinatura.

### A09 — Security Logging and Monitoring Failures
Logging e monitoramento insuficientes — incidentes não detectados.

### A10 — Server-Side Request Forgery (SSRF)
Aplicação faz requisições a destinos controlados pelo atacante.

## Tabela de mapeamento (preencha no relatório)

| ID Achado | Categoria OWASP | Severidade | Status |
|-----------|-----------------|------------|--------|
| F-001 | A01 | High | Confirmado |
| | | | |
