#!/bin/bash

set -e

TEMPLATE_DIR="$(realpath ./template)"  # ✅ Caminho absoluto
PROJECT_NAME="${1:-meu-projeto-js}"

echo "📁 Criando projeto: $PROJECT_NAME"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

[ -f "$TEMPLATE_DIR/docker-compose.yml" ] && cp "$TEMPLATE_DIR/docker-compose.yml" . || echo "⚠️  docker-compose.yml não encontrado."

docker compose up --build -d
nodocker set base-node

echo "📦 Inicializando com Yarn..."
yarn init

if [ ! -f package.json ]; then
  echo "❌ ERRO: package.json não foi criado!"
  exit 1
fi

echo "📚 Instalando dependências..."
yarn add express dotenv ejs cors helmet morgan rotating-file-stream
yarn add -D nodemon jest eslint

echo "📂 Criando estrutura de diretórios..."
mkdir -p src/{controllers,models,routes,services,utils,views,public/assets} \
         tests config docker logs data certs debug output scripts middlewares factories


echo "📄 Movendo arquivos de configuração do template..."
for file in .gitignore jest.config.mjs Makefile example.env .yarnrc.yml; do
  [ -f "$TEMPLATE_DIR/$file" ] && cp "$TEMPLATE_DIR/$file" . || echo "⚠️  $file não encontrado."
done

[ -f "$TEMPLATE_DIR/server.js" ] && cp "$TEMPLATE_DIR/server.js" src/server.js || echo "⚠️  service não encontrado."
[ -f "$TEMPLATE_DIR/app.js" ] && cp "$TEMPLATE_DIR/app.js" src/app.js || echo "⚠️  app não encontrado."

[ ! -f README.md ] && touch README.md

echo "⚙️  Configurando scripts no package.json..."
jq '.scripts = {
  dev: "nodemon src/server.js",
  start: "node src/server.js",
  test: "jest",
  lint: "eslint . --fix"
}' package.json > tmp.json && mv -f tmp.json package.json

make

echo "✅ Projeto '$PROJECT_NAME' criado com sucesso!"
