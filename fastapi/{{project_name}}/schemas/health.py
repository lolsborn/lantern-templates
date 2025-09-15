"""Health check schemas."""

from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field


class HealthResponse(BaseModel):
    """Health check response schema."""

    status: str = Field(description="Application status")
    timestamp: datetime = Field(description="Current timestamp")
    version: str = Field(description="Application version")
    uptime: Optional[float] = Field(None, description="Uptime in seconds")

    class Config:
        json_schema_extra = {
            "example": {
                "status": "healthy",
                "timestamp": "2024-01-01T00:00:00Z",
                "version": "0.1.0",
                "uptime": 3600.0,
            }
        }