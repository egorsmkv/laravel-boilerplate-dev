# Laravel Boilerplate for Production

### Requirements

- Docker Engine 24.x

### Usage

Run the following commands to install this project:

```bash
# Create the app docker image
docker build --tag laravel_app_prod:1.0 .

# Up containers
docker compose up -d

# Up queue workers
docker compose -f docker-compose.workers.yml up -d

# Set apps container name
APPS_CONTAINER=laravel-boilerplate-prod-apps-1 # bash
set APPS_CONTAINER laravel-boilerplate-prod-apps-1 # fish

# Migrate
docker exec -it $APPS_CONTAINER php artisan migrate
```

### Useful commands

Enter the container:

```bash
# Enter the container
docker exec -it $APPS_CONTAINER bash
```

Check usage of resources:

```bash
docker stats --no-stream
```
