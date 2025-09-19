# {{project_name}}

A FastAPI application generated from the [Lantern](https://lantern.bitsetters.com) template with synchronous database operations using SQLAlchemy.

## Features

- **FastAPI**: Modern, fast web framework for building APIs with Python
- **Synchronous SQLAlchemy**: Database ORM with synchronous operations
- **PostgreSQL**: Production-ready database with Docker setup
- **Pydantic**: Data validation and settings management using Python type annotations
- **Structured Logging**: Using structlog for better log management
- **CORS Support**: Pre-configured CORS middleware
- **Health Checks**: Built-in health, readiness, and liveness endpoints
- **Code Quality**: Pre-configured linting (Ruff), type checking (MyPy), and testing (Pytest)


## Quick Start

### Prerequisites

- Python 3.11+
- Docker and Docker Compose (for database)
- UV or pip for dependency management

### Installation

1. **Clone and setup the project:**
   ```bash
   # If using UV
   uv sync

   # If using pip
   pip install -e .
   ```

2. **Start the PostgreSQL database:**
   ```bash
   docker compose up -d db
   ```

3. **Configure environment variables:**
   Create a `.env` file in the project root:
   ```env
   DATABASE_URL=postgresql+psycopg2://postgres:postgres@localhost:7432/{{project_name}}
   SECRET_KEY=your-secret-key-change-in-production
   DEBUG=true
   HOST=127.0.0.1
   PORT=8000
   ```

4. **Run the development server:**
   ```bash
   # Using poe (recommended)
   poe dev

   # Or manually
   uvicorn {{project_name}}.main:app --host 0.0.0.0 --port 8000 --reload
   ```

The API will be available at:
- **API**: http://localhost:8000
- **Interactive API docs**: http://localhost:8000/docs
- **Alternative API docs**: http://localhost:8000/redoc

## Available Endpoints

### Health Checks
- `GET /health/` - Basic health check
- `GET /health/ready` - Readiness check for Kubernetes
- `GET /health/live` - Liveness check for Kubernetes

### Users API
- `POST /api/v1/users/` - Create a new user
- `GET /api/v1/users/` - List users with pagination
- `GET /api/v1/users/{user_id}` - Get user by ID
- `PUT /api/v1/users/{user_id}` - Update user
- `DELETE /api/v1/users/{user_id}` - Delete user

### Items API
- `POST /api/v1/items/` - Create a new item
- `GET /api/v1/items/` - List items with pagination
- `GET /api/v1/items/{item_id}` - Get item by ID
- `PUT /api/v1/items/{item_id}` - Update item
- `DELETE /api/v1/items/{item_id}` - Delete item

## Development

### Running Tests
```bash
# Run tests with coverage
poe test

# Run tests manually
pytest --cov={{project_name}} --cov-report=term-missing
```

### Code Quality
```bash
# Lint code
poe lint

# Format code
ruff format .

# Type checking
mypy {{project_name}}
```

### Database Operations

The application uses synchronous SQLAlchemy operations. Database initialization happens automatically on startup, creating all necessary tables.

#### Database Configuration
- **Engine**: Synchronous SQLAlchemy engine
- **Sessions**: Standard SQLAlchemy sessions (not async)
- **Models**: Standard SQLAlchemy declarative models

#### Example Usage
```python
from sqlalchemy.orm import Session
from {{project_name}}.core.database import get_db

def some_operation(db: Session = Depends(get_db)):
    # All database operations are synchronous
    result = db.execute(select(User).where(User.id == 1))
    user = result.scalar_one_or_none()

    # Commit changes
    db.commit()
```

## Configuration

All configuration is managed through environment variables and the `Settings` class in `{{project_name}}/core/config.py`:

| Variable | Default | Description |
|----------|---------|-------------|
| `HOST` | `127.0.0.1` | Server host |
| `PORT` | `8000` | Server port |
| `DEBUG` | `true` | Debug mode |
| `DATABASE_URL` | `postgresql+psycopg2://postgres:postgres@localhost:7432/{{project_name}}` | Database connection URL |
| `DATABASE_ECHO` | `false` | Enable SQLAlchemy query logging |
| `SECRET_KEY` | `your-secret-key-change-in-production` | Secret key for JWT tokens |
| `CORS_ORIGINS` | `["http://localhost:3000", "http://localhost:8080"]` | Allowed CORS origins |

## Docker

A `docker-compose.yml` file is included for easy PostgreSQL setup:

```bash
# Start PostgreSQL
docker compose up -d db

# View logs
docker compose logs -f db

# Stop services
docker compose down
```

## Production Deployment

For production deployment:

1. Set appropriate environment variables
2. Use a production WSGI server like Gunicorn
3. Configure a reverse proxy (nginx)
4. Set up proper database connection pooling
5. Enable SSL/TLS

Example production command:
```bash
gunicorn {{project_name}}.main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
```
