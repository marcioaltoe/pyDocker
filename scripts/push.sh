#!/bin/bash

# Parâmetros
IMAGE_NAME=${1:-pybi}
IMAGE_TAG=${2:-latest}
DOCKER_HUB_USER=${3}

# Logando no Docker Hub
echo "Logando no Docker Hub..."
docker login --username $DOCKER_HUB_USER

# Realizando o push da imagem
docker tag $IMAGE_NAME:$IMAGE_TAG $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG
docker push $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG

# Indicando o sucesso da operação
echo "Imagem $DOCKER_HUB_USER/$IMAGE_NAME:$IMAGE_TAG enviada com sucesso."
