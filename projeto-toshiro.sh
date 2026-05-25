#!/bin/bash

echo "--- Iniciando o Desafio Toshiro Shibakita: Infraestrutura como Código ---"

# 1. Inicializando o Cluster Swarm (se já não estiver iniciado)
echo "Verificando estado do Swarm..."
if [ "$(docker info --format '{{.Swarm.LocalNodeState}}')" != "active" ]; then
    docker swarm init
else
    echo "Swarm já está ativo."
fi

# 2. Criando a rede overlay para os serviços
echo "Criando rede overlay 'dio-network'..."
docker network create --driver overlay dio-network 2>/dev/null || echo "Rede já existe."

# 3. Construindo as imagens (Dockerfile)
echo "Construindo imagens personalizadas..."
docker build -t meu-site-php:1.0 .

# 4. Fazendo o deploy da Stack (usando seu docker-compose.yml)
echo "Realizando o deploy da stack 'projeto-toshiro'..."
docker stack deploy -c docker-compose.yml projeto-toshiro

# 5. Listando os serviços para validar
echo "Aguardando serviços subirem..."
sleep 5
docker service ls

echo "--- Script Finalizado! Acesse o site no IP do servidor. ---"
