---
name: nuclei
description: "Scan de vulnerabilidades baseado em templates da comunidade com Nuclei (CVEs, exposições, misconfigurations, takeovers). Use quando o usuário pedir 'nuclei', 'scan de vulns', 'CVE check' ou similar. IMPORTANTE: scan ativo significativo — confirme rate limit, janela e exclua tags dos/intrusive ANTES de executar. Achados sempre passam por /validate."
disable-model-invocation: false
allowed-tools: Bash, Read, Write
metadata:
  version: "1.0"
  category: active-offensive
  requires-explicit-confirmation: "true"
  framework: offensive-security-template
---

# Scan de Vulnerabilidades por Templates

Roda o Nuclei (ProjectDiscovery) com templates da comunidade para detectar
CVEs conhecidos, misconfigurations, exposições e takeovers.

## Pré-checagem
- Alvos vivos de `findings/recon/live_hosts.txt`.
- Scan ativo → requer `profundidade: standard`+.
- **Ajuste o rate** ao escopo. Por padrão evite templates intrusivos/DoS.

## Uso

```bash
# Atualizar templates antes
nuclei -update-templates

# Scan padrão sobre hosts vivos (severidades relevantes)
nuclei -l live_hosts.txt \
  -severity low,medium,high,critical \
  -rate-limit 30 -c 25 \
  -o nuclei_results.txt

# Categorias específicas (mais focado, menos ruído)
nuclei -l live_hosts.txt -tags cve,exposure,misconfig,takeover \
  -rate-limit 30 -o nuclei_focused.txt

# Excluir templates intrusivos / de negação de serviço
nuclei -l live_hosts.txt -exclude-tags dos,intrusive,fuzz \
  -rate-limit 30 -o nuclei_safe.txt

# Exposições de painéis/login
nuclei -l live_hosts.txt -tags panel,login -o nuclei_panels.txt
```

## Boas práticas
- Sempre `-exclude-tags dos,intrusive` em produção, salvo autorização explícita.
- Comece com `-severity high,critical` para triar o que importa, depois amplie.
- Nuclei gera falsos positivos — **todo achado vai para `/validate`** antes do relatório.

## Saída
- `findings/recon/nuclei_results.txt` — achados brutos
- Cada achado confirmado vira um `findings/F-XXX-*.md`, mapeado ao OWASP.

> Nuclei é poderoso e barulhento. Respeite rate limit e a janela de testes.
> Não use templates marcados como `dos` contra alvos de produção.
