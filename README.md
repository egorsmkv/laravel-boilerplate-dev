# Laravel Boilerplate for Production

### Requirements

- Docker Engine 24.x

### Usage

Run the following commands to install this project:

```bash
# Create the app docker image
docker build --tag laravel_app:1.0 .

# Up containers
docker compose up

# Copy Laravel environment variables file
cp -n dev-frontend.env apps/frontend/.env

# Set apps container name
APPS_CONTAINER=laravel-boilerplate-dev-apps-1 # bash
set APPS_CONTAINER laravel-boilerplate-dev-apps-1 # fish

# Install required libraries
docker exec -it $APPS_CONTAINER bash -c 'composer install && php artisan telescope:install && bun install'

# Generate "APP_KEY"
docker exec -it $APPS_CONTAINER php artisan key:generate

# Apply migrations
docker exec -it $APPS_CONTAINER php artisan migrate
```

### Useful commands

Use Vite:

```bash
# Start dev server
docker exec -it $APPS_CONTAINER bun run dev

# Build for production
docker exec -it $APPS_CONTAINER bun run build
```

Start queue worker:

```bash
docker exec -it $APPS_CONTAINER php artisan queue:listen -vvv
```

Check usage of resources:

```bash
docker stats --no-stream
```

### Profiling

Access `http://localhost/?SPX_KEY=dev&SPX_UI_URI=/` to enable PHP-SPX and see the profiling results.

### Maintenance

Read the UPDATE.md file to keep the project up to date.
