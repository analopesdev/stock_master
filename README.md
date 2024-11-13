# StockMaster

StockMaster é uma aplicação simples de gerenciamento de estoque desenvolvida com Elixir e o framework Phoenix. O projeto é voltado para controle básico de inventário, fornecendo funcionalidades para cadastro de produtos, fornecedores e controle de movimentações de entrada e saída de estoque.

## Índice

- [Funcionalidades](#funcionalidades)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Uso](#uso)
- [API Endpoints](#api-endpoints)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Funcionalidades

- **Cadastro de Produtos**: Crie, edite e exclua produtos no sistema com atributos como nome, descrição, preço e quantidade.
- **Gestão de Fornecedores**: Cadastre e gerencie fornecedores com informações de contato e endereço.
- **Controle de Estoque**: Registre entradas e saídas de produtos, acompanhando o saldo atualizado em estoque.
- **Relatório de Movimentações**: Histórico de movimentações de estoque, com filtros para consulta detalhada.

## Requisitos

- **Elixir** v1.13 ou superior
- **Phoenix Framework** v1.6 ou superior
- **PostgreSQL** para o banco de dados
- **Docker** (opcional, para facilitar o ambiente de desenvolvimento)

## Instalação

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/stock_master.git
   cd stock_master
