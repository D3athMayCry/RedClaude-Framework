# Metodologia — OSSTMM (Open Source Security Testing Methodology Manual)

> Ative com `metodologias.osstmm: true`. OSSTMM foca em **medição de segurança
> operacional** através de canais. Útil para engajamentos abrangentes (corporate,
> red team) onde se quer métrica e cobertura, não só lista de vulns.

## Conceito central

OSSTMM mede a **superfície de ataque operacional** quantitativamente, em vez de
apenas listar falhas. O foco é: quanto da segurança esperada realmente existe?

## Os 5 canais

### 1. Humano (Human Security)
- Pessoal, conscientização, processos
- Engenharia social (somente se `permite_engenharia_social: true`)

### 2. Físico (Physical Security)
- Controle de acesso físico, perímetro
- (Geralmente fora de escopo em testes remotos)

### 3. Sem fio (Wireless / Spectrum Security)
- Wi-Fi, Bluetooth, RFID, sinais
- Relevante em red team on-site

### 4. Telecomunicações (Telecommunications)
- PBX, VoIP, redes de telecom

### 5. Redes de Dados (Data Networks)
- O canal mais comum em pentest: infraestrutura, serviços, aplicações

## Conceitos de medição

| Conceito | O que avalia |
|----------|--------------|
| **Visibility** | O que é detectável/enumerável no alvo |
| **Access** | Pontos de interação disponíveis |
| **Trust** | Relações de confiança entre componentes |
| **Controls** | Mecanismos de proteção presentes |
| **RAV** (Risk Assessment Value) | Métrica numérica do estado de segurança |

## Fases operacionais (resumo)

1. **Indução** — entender o ambiente e regras
2. **Interação** — enumerar pontos de acesso e visibilidade
3. **Inquérito** — coletar dados sobre confiança e controles
4. **Intervenção** — testar resiliência dos controles (conforme profundidade)

## Quando usar

- Engajamentos corporativos amplos que exigem **métrica de postura**
- Red team querendo mapear **relações de confiança** entre sistemas
- Complementa PTES/WSTG quando o cliente quer mais que uma lista de vulns
