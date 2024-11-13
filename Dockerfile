# Definir a imagem base
FROM elixir:1.14-alpine

# Instalar dependências do sistema
RUN apk add --no-cache build-base nodejs npm git

# Criar o diretório de trabalho
WORKDIR /app

# Instalar o Hex e o Rebar (necessários para gerenciar dependências)
RUN mix local.hex --force && mix local.rebar --force

# Copiar o mix.exs e mix.lock para instalar dependências do Elixir
COPY mix.exs mix.lock ./

# Instalar dependências do Elixir
RUN mix deps.get

# Copiar os arquivos restantes do projeto, incluindo o diretório assets
COPY . .

# Instalar dependências do npm
RUN npm install --prefix ./assets

# Rodar o comando de deploy do npm
RUN npm run deploy --prefix ./assets

# Rodar o comando mix phx.digest para compilar assets estáticos
RUN mix phx.digest

# Rodar a aplicação (ajuste conforme o seu comando de inicialização)
CMD ["mix", "phx.server"]
