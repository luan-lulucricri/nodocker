# Node Docker Scripts

Este projeto contém scripts para facilitar a execução do ambiente Node.js dentro de um container Docker. 

## Sobre:

Este projeto foi criado para facilitar o gerenciamento de um ambiente Node.js utilizando Docker. Com ele, você pode executar diferentes versões do Node no seu sistema sem precisar instalá-las diretamente, evitando conflitos entre versões e mantendo seu ambiente limpo.

Além disso, ele permite rodar aplicações simples, como APIs, sem a necessidade de gerenciar arquivos docker-compose.yml ou Dockerfile, tornando o processo mais ágil e prático. Assim, você pode aproveitar a flexibilidade do Docker sem complicações, executando seus projetos de forma isolada e organizada.

## Como Clonar o Repositório

Para obter os arquivos deste repositório, clone-o usando o seguinte comando:

```bash
git clone https://github.com/luan-lulucricri/nodocker.git
cd nodocker
```

## Instalação

Os arquivos contidos na pasta `bin/` devem ser copiados para `/usr/local/bin/` para que possam ser executados globalmente. Para isso, utilize o seguinte comando:

```bash
sudo cp bin/* /usr/local/bin/
```

### Dando Permissão de Execução

Após a cópia, conceda permissão de execução aos arquivos:

```bash
sudo chmod +x /usr/local/bin/node
sudo chmod +x /usr/local/bin/nodocker
sudo chmod +x /usr/local/bin/npm
sudo chmod +x /usr/local/bin/npx
sudo chmod +x /usr/local/bin/yarn
```

## Criando Alias

Caso prefira, pode-se criar aliases para os comandos, facilitando sua execução. Adicione as seguintes linhas ao seu `.bashrc` ou `.zshrc`:

```bash
alias nodocker="/usr/local/bin/nodocker"
alias node="/usr/local/bin/node"
alias npm="/usr/local/bin/npm"
alias npx="/usr/local/bin/npx"
alias yarn="/usr/local/bin/yarn"
```

Após adicionar os aliases, recarregue o perfil:

```bash
source ~/.bashrc  # Para bash
source ~/.zshrc   # Para zsh
```

## Executando sem Privilégios de Root

Se deseja permitir que um usuário não root execute os containers do Docker, adicione-o ao grupo `docker`:

```bash
sudo usermod -aG docker $USER
```

Após isso, faça logout e login novamente ou execute:

```bash
newgrp docker
```

## Como Usar

Os scripts permitem interagir com o container de Node.js sem precisar executar manualmente os comandos `docker exec`. 

### Configurando o Node.js

Primeiro, defina a versão do container Node.js para que os scripts saibam qual versão utilizar:

```bash
nodocker set-node-version <Versão node ex: 20>
```

### Configurando o Container

Defina o nome do container para que os scripts saibam qual container utilizar:

```bash
nodocker set <meu-container>
```

### Criando e Iniciando o Container

Para criar e iniciar o container com o nome definido:

```bash
nodocker start
```

Se o container já existir, ele será apenas iniciado.

### Parando o Container

```bash
nodocker stop
```

### Removendo o Container

```bash
nodocker remove
```

### Verificando o Status do Container

```bash
nodocker status
```

### Abrindo um Shell no Container

```bash
nodocker shell
```

### Resetando a Configuração

Se quiser remover a configuração do container:

```bash
nodocker unset
```

### Executando Comandos no Container

Depois que o container estiver rodando, você pode usar os scripts para executar comandos dentro dele:

- **Node.js**: `node app.js`
- **NPM**: `npm install`
- **NPX**: `npx create-react-app my-app`
- **Yarn**: `yarn add express`

## Considerações Finais

Este conjunto de scripts facilita o uso do Node.js dentro de um container Docker, sem necessidade de escrever comandos longos repetidamente. Além disso, permite a persistência da configuração e um fluxo de trabalho mais organizado.