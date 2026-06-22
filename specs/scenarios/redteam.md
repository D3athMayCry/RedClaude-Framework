# Profile — Red Team Operations

> Ativado por `cenario: [redteam]`. Operação adversarial orientada a objetivos.
> Combine PTES + OSSTMM. Exige `profundidade: full` e autorizações explícitas.

## Diferença para pentest
Pentest busca **amplitude** (achar o máximo de vulns). Red team busca **objetivo
específico** (ex: acessar a base de clientes) emulando um adversário real, com
foco em evasão de detecção.

## Pré-requisitos no CONFIG
- `permite_exploracao_ativa: true`
- `permite_pos_exploracao: true`
- Objetivo(s) definido(s) claramente no escopo ("crown jewels")
- Regras sobre stealth e o que a equipe defensiva (blue team) sabe

## Fases (kill chain)

### 1. Recon
- OSINT amplo: pessoas, tecnologias, exposição externa
- Mapeamento de superfície sem alertar o alvo

### 2. Acesso inicial
- Definir vetor (conforme autorizado: phishing se permitido, exposição externa)
- Estabelecer ponto de entrada

### 3. Estabelecimento e C2
- Persistência conforme escopo
- Comunicação de comando e controle

### 4. Escalonamento e movimento lateral
- Elevar privilégios
- Mover-se em direção ao objetivo

### 5. Ação sobre o objetivo
- Alcançar a "crown jewel" definida
- Provar o impacto sem causar dano real

### 6. Relatório e debrief
- Linha do tempo do ataque
- O que foi/não foi detectado
- Recomendações para o blue team

## Princípios
- **Objetivo > amplitude.** Foque na missão, não em listar tudo.
- **Stealth conforme acordado.** Documente o que foi detectado.
- **Sem dano real.** Prove o acesso; não destrua nem exfiltre dados reais.
- **Comunicação constante** com o ponto de contato para emergências.

> Red team tem o maior potencial de impacto. A autorização e o escopo precisam
> ser excepcionalmente claros. Em dúvida, pare e confirme.
