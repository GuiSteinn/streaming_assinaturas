# Sistema Especialista: Streaming & Assinaturas

Este é um sistema especialista desenvolvido em Prolog para calcular o valor proporcional de cobranças em mudanças de planos de streaming, utilizando cálculos pro-rata baseados nos dias utilizados de cada plano.

## Pré-requisitos

- SWI-Prolog instalado no sistema
- Conhecimento básico de comandos do terminal

## Estrutura do Projeto

```
streaming_assinaturas/
└── src/
    ├── main.pl      # Menu principal e orquestração
    ├── kb.pl        # Base de conhecimento (fatos sobre planos)
    ├── rules.pl     # Regras de negócio e cálculos
    ├── ui.pl        # Interface com usuário
    └── explain.pl   # Sistema de explicação
```

## Como Executar

1. Abra o terminal do SWI-Prolog
2. Carregue o arquivo principal usando:
   ```prolog
   ?- [src/main].
   ```
3. Inicie o sistema com o comando:
   ```prolog
   ?- start.
   ```

## Usando o Sistema

1. Ao iniciar, você verá o banner do sistema e um menu com duas opções:
   - 1) Calcular migração de plano
   - 2) Sair

2. Escolha a opção 1 para calcular uma migração de plano

3. O sistema solicitará as seguintes informações:
   - Plano atual (basico/padrao/premium)
   - Novo plano desejado (basico/padrao/premium)
   - Quantidade de dias já utilizados no mês

4. Após fornecer as informações, o sistema apresentará:
   - Uma explicação detalhada do cálculo
   - O valor final a ser cobrado

## Valores dos Planos

- Plano Básico: R$ 20,00
- Plano Padrão: R$ 35,00
- Plano Premium: R$ 55,00

## Exemplo de Uso

```
?- start.

=== Sistema Especialista: Streaming & Assinaturas ===
Desenvolvido por: Guilherme Sgrott

1) Calcular migracao de plano
2) Sair
> 1.

Plano atual (basico/padrao/premium): basico.
Novo plano desejado (basico/padrao/premium): premium.
Quantos dias do mes ja foram usados antes da mudanca?: 15.

[Explicacao]
- Plano anterior: basico (R$ 20.00/mes)
- Novo plano: premium (R$ 55.00/mes)
- Dias utilizados antes da troca: 15 de 30
- Foi aplicado calculo de pro-rata (cobranca proporcional).
- Valor total a cobrar neste mes: R$ 37.50

RESULTADO: resultado(plano_atual(basico),plano_novo(premium),valor_cobrado(37.5))
```

## Regras de Negócio

O sistema implementa as seguintes regras principais:

1. Validação dos tipos de plano (básico, padrão, premium)
2. Cálculo proporcional dos dias utilizados do plano atual
3. Cálculo proporcional dos dias restantes com o novo plano
4. Arredondamento do valor final para duas casas decimais
5. Validação da quantidade de dias (entre 1 e 30)
6. Tratamento de mudança para o mesmo tipo de plano
7. Cálculo do valor pro-rata baseado em mês de 30 dias
8. Limpeza de observações após cada consulta

## Limitações

- O sistema considera meses de 30 dias fixos
- Não há persistência de dados entre execuções
- Valores dos planos são fixos na base de conhecimento
- Não há tratamento de datas específicas do calendário

## Desenvolvedor

- Guilherme Sgrott 
- Samuel Wiggers 