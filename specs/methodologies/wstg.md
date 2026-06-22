# Metodologia — WSTG (OWASP Web Security Testing Guide)

> Ative com `metodologias.wstg: true`. Use como checklist de cobertura para
> testes Web. Referência: OWASP WSTG v4.2.

O Claude deve percorrer as categorias aplicáveis ao alvo, respeitando a
`profundidade` definida no CONFIG. Marque o que foi coberto em `findings/`.

## Categorias

### WSTG-INFO — Coleta de Informações
- [ ] Reconhecimento de motores de busca / leak de informação
- [ ] Fingerprint do servidor web e tecnologias
- [ ] Enumeração de aplicações e metadados expostos
- [ ] Mapeamento de superfície de ataque e pontos de entrada
- [ ] Identificação de frameworks e versões

### WSTG-CONF — Configuração e Deploy
- [ ] Configuração de infraestrutura e plataforma
- [ ] Arquivos e diretórios sensíveis expostos
- [ ] Métodos HTTP permitidos
- [ ] HSTS, política de cabeçalhos de segurança
- [ ] Subdomain takeover
- [ ] Configuração de nuvem (buckets, storage)

### WSTG-IDNT — Gestão de Identidade
- [ ] Políticas de registro e provisionamento de contas
- [ ] Enumeração de usuários
- [ ] Política de nomes de usuário previsíveis

### WSTG-ATHN — Autenticação
- [ ] Transmissão de credenciais por canal cifrado
- [ ] Credenciais padrão
- [ ] Mecanismo de bloqueio (lockout)
- [ ] Bypass de autenticação
- [ ] Lembrança de senha / função de recuperação
- [ ] Cache de navegador em telas autenticadas
- [ ] Política de senhas fracas

### WSTG-ATHZ — Autorização
- [ ] Path traversal / directory traversal
- [ ] Bypass de esquema de autorização
- [ ] Escalonamento de privilégios (vertical/horizontal)
- [ ] IDOR (Insecure Direct Object Reference)

### WSTG-SESS — Gestão de Sessão
- [ ] Esquema de gerenciamento de sessão
- [ ] Atributos de cookie (HttpOnly, Secure, SameSite)
- [ ] Fixação de sessão
- [ ] Variáveis de sessão expostas
- [ ] CSRF
- [ ] Logout e timeout de sessão

### WSTG-INPV — Validação de Entrada
- [ ] XSS refletido, armazenado e DOM-based
- [ ] Injeção SQL, NoSQL, ORM, LDAP, XML/XXE
- [ ] Injeção de comando do SO
- [ ] SSTI (Server-Side Template Injection)
- [ ] HTTP splitting / smuggling
- [ ] Open redirect

### WSTG-ERRH — Tratamento de Erros
- [ ] Mensagens de erro verbosas / stack traces
- [ ] Páginas de erro padrão revelando tecnologia

### WSTG-CRYP — Criptografia
- [ ] TLS fraco / cifras obsoletas
- [ ] Padding oracle
- [ ] Dados sensíveis enviados em claro

### WSTG-BUSL — Lógica de Negócio
- [ ] Validação de lógica de negócio
- [ ] Capacidade de forjar requisições
- [ ] Limites de integridade e fluxo de trabalho
- [ ] Upload de arquivos malicioso / tipos não esperados

### WSTG-CLNT — Lado Cliente
- [ ] DOM-based XSS
- [ ] JavaScript execution / HTML injection
- [ ] CSS injection / clickjacking
- [ ] CORS mal configurado
- [ ] WebSockets e postMessage inseguros

### WSTG-APIT — APIs (ponte para owasp-api-top10.md)
- [ ] Testes de GraphQL / REST conforme escopo

## Mapeamento de profundidade

| profundidade | Cobertura WSTG |
|--------------|----------------|
| recon-only   | Apenas WSTG-INFO (passivo) |
| passive      | WSTG-INFO + WSTG-CONF (sem testes intrusivos) |
| standard     | Todas as categorias em modo de detecção não-destrutiva |
| deep         | Inclui PoC controlada para achados confirmados |
| full         | Inclui encadeamento de vulns e pós-exploração (se autorizado) |
