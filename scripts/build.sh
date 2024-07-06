#!/bin/bash

# Parâmetros
IMAGE_NAME=${1:-py-docker}
IMAGE_TAG=${2:-latest}

# Construindo a imagem Docker
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Indicando o sucesso da operação
echo "Imagem $IMAGE_NAME:$IMAGE_TAG construída com sucesso."
