# Agent Context for {{project_name}}

This document provides context for AI agents working with this FastAPI project template.

## Project Overview

This is a **FastAPI application** using:
- **SQLAlchemy** with synchronous operations (no async/await in database code)
- **PostgreSQL** as the primary database
- **Pydantic** for data validation and settings
- **Structured logging** with structlog
- **Standard REST API** patterns with CRUD operations

## Key Architecture Decisions

### Database Layer
- **Synchronous SQLAlchemy**: All database operations use standard `Session` objects, not `AsyncSession`
- **No async/await**: Database code uses synchronous patterns: `db.execute()`, `db.commit()`, `db.refresh()`
- **Session Management**: Uses dependency injection with `get_db()` generator function
- **Models**: Located in `{{project_name}}/models/` using SQLAlchemy declarative base

### API Structure
- **Routers**: Organized by resource (`users.py`, `items.py`, `health.py`)
- **Schemas**: Pydantic models in `{{project_name}}/schemas/` for request/response validation
- **No async route handlers**: All route functions are synchronous (no `async def`)

### Configuration
- **Environment-based**: Uses Pydantic Settings with `.env` file support
- **Centralized**: All settings in `{{project_name}}/core/config.py`
- **Type-safe**: Full type annotations with Pydantic validation

## Development Patterns

### Adding New Endpoints
1. Create Pydantic schemas in `schemas/`
2. Create SQLAlchemy model in `models/`
3. Create router in `routers/` with synchronous functions
4. Register router in `main.py`

### Database Operations
```python
# Correct pattern (synchronous)
def get_user(user_id: int, db: Session = Depends(get_db)):
    result = db.execute(select(User).where(User.id == user_id))
    user = result.scalar_one_or_none()
    return user

# Update pattern
def update_user(user_id: int, data: UserUpdate, db: Session = Depends(get_db)):
    user = db.execute(select(User).where(User.id == user_id)).scalar_one_or_none()
    for field, value in data.model_dump(exclude_unset=True).items():
        setattr(user, field, value)
    db.commit()
    db.refresh(user)
    return user
```

### Error Handling
- Use FastAPI's `HTTPException` for API errors
- Standard HTTP status codes (404 for not found, 400 for bad request, etc.)
- Consistent error response format

## Available Tools & Commands

### Development
```bash
poe dev          # Start development server with database
poe test         # Run tests with coverage
poe lint         # Lint code with Ruff
```

### Database
- **Auto-initialization**: Database tables created on startup via `init_db()`
- **Connection**: PostgreSQL on localhost:7432 (Docker)
- **Migrations**: Alembic included but not configured (for future use)

## File Structure Context

```
{{project_name}}/
├── core/
│   ├── config.py      # Settings and environment variables
│   └── database.py    # DB engine, session, and base model
├── models/           # SQLAlchemy models
├── routers/         # API route handlers (synchronous)
├── schemas/         # Pydantic request/response models
└── main.py          # FastAPI app factory
```

## Common Operations for Agents

### Adding a New Resource
1. **Model**: Create SQLAlchemy model in `models/`
2. **Schemas**: Create Pydantic models in `schemas/`
3. **Router**: Create router file in `routers/` with CRUD operations
4. **Registration**: Add router to `main.py`
5. **Import**: Add model import to `database.py` for table creation

### Debugging Database Issues
- Check `DATABASE_URL` in environment/config
- Verify PostgreSQL is running: `docker compose up -d db`
- Enable query logging: `DATABASE_ECHO=true`

### Code Quality
- All functions must have type annotations
- Use Pydantic for data validation
- Follow existing patterns for consistency
- No async/await in this codebase

## Important Notes for Agents

- **This is a synchronous codebase** - do not add async/await patterns
- **Database sessions** are standard SQLAlchemy sessions, not async
- **Route handlers** are synchronous functions
- **Dependencies** use standard FastAPI dependency injection
- **Environment variables** are managed through Pydantic Settings
- **Testing** uses pytest with httpx for client testing

When working with this codebase, maintain consistency with the synchronous patterns already established.