"""Health check router."""

import time
from datetime import datetime

from fastapi import APIRouter

from ..schemas.health import HealthResponse

router = APIRouter()

# Store application start time for uptime calculation
_start_time = time.time()


@router.get("/", response_model=HealthResponse)
async def health_check() -> HealthResponse:
    """Basic health check endpoint."""
    return HealthResponse(
        status="healthy",
        timestamp=datetime.utcnow(),
        version="0.1.0",
        uptime=time.time() - _start_time,
    )


@router.get("/ready", response_model=HealthResponse)
async def readiness_check() -> HealthResponse:
    """Readiness check endpoint for Kubernetes."""
    return HealthResponse(
        status="ready",
        timestamp=datetime.utcnow(),
        version="0.1.0",
        uptime=time.time() - _start_time,
    )


@router.get("/live", response_model=HealthResponse)
async def liveness_check() -> HealthResponse:
    """Liveness check endpoint for Kubernetes."""
    return HealthResponse(
        status="alive",
        timestamp=datetime.utcnow(),
        version="0.1.0",
        uptime=time.time() - _start_time,
    )