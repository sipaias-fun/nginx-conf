_Export variable SSH KEY_

```
docker exec -it 49a37225e93e /bin/bash
```

```
export CR_PAT=secret_key_from_github
```

```
echo $CR_PAT | docker login ghcr.io -u andreaszico --password-stdin
```

```
docker build . -t ghcr.io/andreaszico/sipaias-fun:latest && docker push ghcr.io/andreaszico/sipaias-fun:latest
```

```
ssh-keygen -t rsa -b 4096
```

```
more ~/.ssh/id_rsa
```

```
cat ~/.ssh/id_rsa.pub >> ~/.ssh/key
```

```
After creating the SSH key, we need to create the following secrets in the repository by going to Settings > Secrets and Variables > Actions:

SSH_PRIVATE_KEY: content of the private key file
SSH_USER: user to access the server
SSH_HOST: IP of your server
WORK_DIR: path to the directory containing the docker-compose.yml file
```

```
docker build . -t ghcr.io/andreaszico/nginx-sipaias:latest && docker push ghcr.io/andreaszico/nginx-sipaias:latest
```

```
services:
  sipaias_web:
    container_name: sipaias_web
    image: ghcr.io/andreaszico/sipaias-fun:latest
    networks:
      - app-network
  webserver:
    container_name: webserver
    image: ghcr.io/andreaszico/nginx-sipaias:latest
    ports:
      - 80:80
    depends_on:
      - sipaias_web
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

```
version: "3"
services:
  sipaias_web:
    container_name: sipaias_web
    image: ghcr.io/andreaszico/sipaias-fun:latest
    networks:
      - app-network
  webserver:
    image: nginx:latest
    container_name: webserver
    restart: unless-stopped
    ports:
      - "80:80"
    volumes:
      - ./config:/etc/nginx/conf.d
    depends_on:
      - sipaias_web
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```

```
version: "3"
services:
  sipaias_web:
    container_name: sipaias_web
    image: ghcr.io/andreaszico/sipaias-fun:latest
    networks:
      - app-network
  webserver:
    container_name: webserver
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 80:80
    depends_on:
      - sipaias_web
    networks:
      - app-network

networks:
  app-network:
    driver: bridge

```

```
FROM nginx:latest

# Copy custom NGINX configuration
COPY config /etc/nginx/nginx.d

# Copy custom entrypoint script
# COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Set execution permissions for the entrypoint script
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Set the entrypoint to the custom script
# ENTRYPOINT ["docker-entrypoint.sh"]

# Continue with default NGINX CMD
CMD ["nginx", "-g", "daemon off;"]
```
