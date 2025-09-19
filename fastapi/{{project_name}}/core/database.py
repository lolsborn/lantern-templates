"""Database configuration and connection management."""

from typing import Generator

from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, Session, sessionmaker

from .config import settings


class Base(DeclarativeBase):
    """Base class for all database models."""

    pass


engine = create_engine(
    settings.database_url,
    echo=settings.database_echo,
)

SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False,
)


def get_db() -> Generator[Session, None, None]:
    """Get database session."""
    session = SessionLocal()
    try:
        yield session
    finally:
        session.close()


def init_db() -> None:
    """Initialize database tables."""
    # Import all models here to ensure they are registered
    from ..models.item import Item  # noqa: F401
    from ..models.user import User  # noqa: F401

    Base.metadata.create_all(bind=engine)