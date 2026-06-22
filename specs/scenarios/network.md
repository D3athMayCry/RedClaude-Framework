# Profile — Infraestrutura / Network

> Ativado por `cenario: [network]`. Combine com PTES + OSSTMM (canal de dados).

## Superfície de ataque
Hosts, portas, serviços de rede, protocolos, segmentação, Active Directory,
serviços expostos (SMB, RDP, SSH, bancos de dados), dispositivos de rede.

## Fluxo por fase

### Recon
- Descoberta de hosts ativos no escopo
- Enumeração de portas e serviços
- Fingerprint de versões e sistemas operacionais
- Mapeamento de topologia e segmentação

### Modelagem de ameaças
- Identificar serviços de alto valor (AD, bancos, gerência)
- Mapear relações de confiança (conceito OSSTMM)
- Priorizar por exposição e criticidade

### Enumeração & Análise
- Enumeração detalhada por serviço (SMB shares, usuários, políticas)
- Identificação de configurações inseguras e serviços desatualizados
- Correlação com vulnerabilidades conhecidas (CVE)

### Exploração (se autorizado)
- PoC controlada — sem afetar disponibilidade de produção
- Documentar cada passo

### Pós-exploração (se autorizado)
- Avaliação de impacto e alcance
- Movimento lateral e escalonamento (conforme escopo)

## Vetores prioritários
1. Serviços expostos com configuração fraca
2. Credenciais padrão / fracas
3. Software desatualizado com CVE conhecido
4. Segmentação de rede insuficiente
5. Protocolos inseguros (SMBv1, Telnet, FTP em claro)

## Cuidados críticos
- **Nunca** rodar scans agressivos contra produção fora da janela autorizada
- Respeitar `rate_limit`; scans podem derrubar serviços frágeis
- Confirmar IPs de origem permitidos no escopo
