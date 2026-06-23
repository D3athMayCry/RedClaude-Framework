# /portscan — Varredura de Portas e Serviços

Identifica portas abertas e serviços nos hosts in-scope.

## Pré-checagem
- **IPs/hosts in-scope explícitos.** Port scan é ativo e intrusivo.
- Confirme `permite` no escopo e respeite a janela. Scans agressivos podem
  derrubar serviços frágeis — comece leve.

## Ferramentas e uso

```bash
# naabu — descoberta rápida de portas abertas
naabu -host alvo.com -top-ports 1000 -rate 1000 -o ports_naabu.txt

# Passar as portas abertas para o nmap fazer enumeração detalhada
naabu -host alvo.com -p - -silent | \
  nmap -sV -sC -iL - -oA nmap_detailed

# nmap direto (quando precisar de scripts específicos)
nmap -sV -sC -p- -T3 --open alvo.com -oA nmap_full
```

Flags úteis: `-sV` versão de serviço, `-sC` scripts default, `-T3` timing
moderado (use `-T2` para ser mais discreto), `--open` só portas abertas.

## Respeite o CONFIG
- `-rate` (naabu) e `-T` (nmap) controlam a intensidade. Ajuste ao `rate_limit`.
- Evite `-T4`/`-T5` contra produção sem autorização clara.

## Saída
- `findings/recon/ports_naabu.txt` — portas abertas
- `findings/recon/nmap_detailed.*` — serviços, versões, scripts

Serviços desatualizados ou inseguros (SMBv1, Telnet, FTP em claro) → `/validate`.
