# py-Docker

Local commands

```bash
docker-compose build

docker tag py-docker:latest marcioaltoe/py-docker:latest
docker tag py-docker-nginx:latest marcioaltoe/py-docker-nginx:latest

docker push marcioaltoe/py-docker:latest
docker push marcioaltoe/py-docker-nginx:latest
```


VPS comands
```bash
docker pull marcioaltoe/py-docker:latest
docker pull marcioaltoe/py-docker-nginx:latest

docker-compose up -d
```

docker-compose.yml
```bash
version: "3.8"
services:
  nginx:
    image: marcioaltoe/py-docker-nginx:latest
    container_name: nginx
    hostname: nginx
    restart: always
    ports:
      - "80:80"
    networks:
      - webapp-network
    depends_on:
      - app

  app:
    image: marcioaltoe/py-docker:latest
    container_name: app
    hostname: app
    restart: always
    environment:
      - FLASK_ENV=production
    networks:
      - webapp-network
    ports:
      - "5050:5050"

networks:
  webapp-network:
    driver: bridge
```
