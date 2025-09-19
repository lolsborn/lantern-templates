# {{project_name}}

A modern Django 5 web application with best practices and modern tooling.

## Features

- **Django 5**: Latest Django framework with async support
- **Modern Python**: Python 3.11+ with type hints and modern syntax
- **REST API**: Django REST Framework with OpenAPI documentation
- **Database**: PostgreSQL with connection pooling
- **Caching**: Redis for caching and session storage
- **Background Tasks**: Celery with Redis broker
- **Code Quality**: Ruff for linting and formatting, mypy for type checking
- **Testing**: pytest with coverage reporting
- **Containerization**: Docker and Docker Compose
- **Security**: Production-ready security settings

## Quick Start

1. **Copy the environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Install dependencies:**
   ```bash
   pip install -e .[dev]
   ```

3. **Run migrations:**
   ```bash
   python manage.py migrate
   ```

4. **Create a superuser:**
   ```bash
   python manage.py createsuperuser
   ```

5. **Start the development server:**
   ```bash
   python manage.py runserver
   ```

## Docker Development

1. **Start all services:**
   ```bash
   docker-compose up
   ```

2. **Run migrations in container:**
   ```bash
   docker-compose exec web python manage.py migrate
   ```

3. **Create superuser in container:**
   ```bash
   docker-compose exec web python manage.py createsuperuser
   ```

## API Documentation

- **Swagger UI**: http://127.0.0.1:8000/api/docs/
- **ReDoc**: http://127.0.0.1:8000/api/redoc/
- **OpenAPI Schema**: http://127.0.0.1:8000/api/schema/

## Available Endpoints

- `GET /api/v1/health/` - Health check
- `GET /api/v1/users/` - List users
- `POST /api/v1/users/` - Create user
- `GET /api/v1/users/me/` - Current user profile
- `GET /api/v1/users/{id}/` - User details

## Code Quality

**Run linting:**
```bash
ruff check .
```

**Run formatting:**
```bash
ruff format .
```

**Run type checking:**
```bash
mypy .
```

## Testing

**Run tests:**
```bash
pytest
```

**Run tests with coverage:**
```bash
pytest --cov={{project_name}}
```

## Project Structure

```
{{project_name}}/
├── {{project_name}}/
│   ├── apps/
│   │   ├── core/          # Core functionality
│   │   └── users/         # User management
│   ├── settings/
│   │   ├── base.py        # Base settings
│   │   ├── development.py # Development settings
│   │   ├── production.py  # Production settings
│   │   └── test.py        # Test settings
│   ├── urls.py
│   ├── wsgi.py
│   ├── asgi.py
│   └── celery.py
├── tests/                 # Test files
├── static/                # Static files
├── media/                 # Media files
├── templates/             # Django templates
├── logs/                  # Log files (production)
├── manage.py
├── pyproject.toml         # Project configuration
├── docker-compose.yml     # Docker services
├── Dockerfile
└── README.md
```

## Environment Variables

See `.env.example` for all available environment variables.

## Deployment

For production deployment:

1. Set `DJANGO_SETTINGS_MODULE={{project_name}}.settings.production`
2. Configure environment variables
3. Run `python manage.py collectstatic`
4. Run migrations
5. Use a production WSGI server like Gunicorn

## Contributing

1. Install development dependencies: `pip install -e .[dev]`
2. Run pre-commit checks: `ruff check . && mypy . && pytest`
3. Ensure all tests pass before submitting changes